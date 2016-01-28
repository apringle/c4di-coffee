import serial
import datetime
import json
import paho.mqtt.client as mqtt

ARDUINO_DEV = '/dev/cu.usbmodem14111'
POT_NAME = 'C4DI_TEST_POT'

serial_instance = serial.Serial(ARDUINO_DEV, 9600)

def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    client.subscribe("$SYS/#")


# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, msg):
    print(msg.topic + " " + str(msg.payload))


mqtt_client = mqtt.Client()
mqtt_client.on_connect = on_connect
mqtt_client.on_message = on_message

mqtt_client.connect("coderave.co.uk", 1883, 60)
mqtt_client.loop_start()

last_time = datetime.datetime.now()


while True:
    message_dict = {}
    line = serial_instance.readline()
    print line
    weight_lbs = float(line)
    weight_kgs = weight_lbs / 2.2046
    message_dict['reading_kg'] = weight_kgs

    time_now = datetime.datetime.now()
    message_dict['time'] = str(time_now)
    message_dict['avg_since'] = str(last_time)
    last_time = time_now

    message_dict['pot_name'] = POT_NAME

    print json.dumps(message_dict)
    mqtt_client.publish('coffee/readings', json.dumps(message_dict))

