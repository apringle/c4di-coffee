import mqtt = require("mqtt");
import pg = require("pg");


//TODO REMOVE PASSWORD 
var dbUrl: string = "tcp://postgres:ilovecoffee@postgres:5432/c4di_coffee_web_dev";
var READINGS_TOPIC: string = "coffee/readings";
var mqttClient  = mqtt.connect('mqtt://mqtt-broker');

mqttClient.on('error', function(error) {
    console.log("MQTT error " + error);
});
mqttClient.on('connect', function () {
    console.log('Connected to mqtt-broker');
    mqttClient.subscribe(READINGS_TOPIC);
    console.log('Subscribed to ' + READINGS_TOPIC);
});
mqttClient.on('message', function(topic, message) {
    console.log(message.toString());
    var json = JSON.parse(message);
    pg.connect(dbUrl, function(err, client, done) {
    	newPot(client, json['pot_name']);
		client.query(
			'INSERT into readings (reading_kg, time, avg_since, pot_name, inserted_at, updated_at) VALUES($1, $2, $3, $4, $5, $6) RETURNING id',
			[json['reading_kg'], json['time'], json['avg_since'], json['pot_name'], new Date(), new Date()],
			function(err, result) {
				if (err) {
					console.log(err);
				} else {
					console.log('row inserted with id: ' + result.rows[0].id);
				}
				client.end();
			});			
		});
});

//Add a new pot if its not in the database.
function newPot(client, pot_name)
{
	client.query(
		'INSERT INTO pots ("pot_name", "empty", "full", "avg_cup", "inserted_at", "updated_at") SELECT $1, 0, 10, 1, $2, $3 WHERE NOT EXISTS (SELECT * FROM pots WHERE pot_name = $4) ',
		[pot_name, new Date(), new Date(), pot_name], //When had $1 in same position as $4 it breaks. error: inconsistent types deduced for parameter $1
		function(err, result){
			if (err) {
				console.log(err);
			} else {
				console.log('pot inserted called: ' + pot_name);
			}
		});
}

