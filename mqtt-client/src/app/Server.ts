var READINGS_TOPIC: string = 'coffee/readings';

import mqtt = require("mqtt");
var client  = mqtt.connect('mqtt://mqtt-broker');

client.on('error', function(error) {
    console.log("MQTT error " + error);
});

client.on('connect', function () {
    console.log('Connected to mqtt-broker');
    client.subscribe(READINGS_TOPIC);
    console.log('Subscribed to ' + READINGS_TOPIC);
});


client.on('message', function (topic, message) {
    console.log(message.toString());
});