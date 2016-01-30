import datetime
import json
import paho.mqtt.client as mqtt
import random
import sched
import time

POT_NAME = 'C4DI_MOCK_POT'

FULL_WEIGHT = 4.9
CHANCE_REFILL_IF_EMPTY = 0.05
CHANCE_OF_CHANGE = 0.05
CHANGES = [0.05, 0.1, 0.13, 0.11, 0.07]


def calc_new_weight(weight):
    rand = random.random()

    if weight < 0:
        if rand < CHANCE_REFILL_IF_EMPTY:
            return FULL_WEIGHT + (1 - rand)
    elif rand < CHANCE_OF_CHANGE:
        return weight - random.choice(CHANGES)
    else:
        return weight


def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))


def on_message(client, userdata, msg):
    print(msg.topic + " " + str(msg.payload))


# connect to broker
mqtt_client = mqtt.Client()
mqtt_client.on_connect = on_connect
mqtt_client.on_message = on_message

mqtt_client.connect("mqtt-broker", 1883, 60)
mqtt_client.loop_start()

#
sched_instance = sched.scheduler(time.time, time.sleep)


def send_reading(reading, last_time):
    message_dict = {'reading_kg': reading}
    time_now = datetime.datetime.now()
    message_dict['time'] = str(time_now)
    message_dict['avg_since'] = str(last_time)
    message_dict['pot_name'] = POT_NAME

    mqtt_client.publish('coffee/readings', json.dumps(message_dict))
    print('Published mock reading ' + str(reading))
    sched_instance.enter(1, 1, send_reading, (calc_new_weight(reading), time_now),)


sched_instance.enter(1, 1, send_reading, (2.5, datetime.datetime.now()),)
sched_instance.run()
