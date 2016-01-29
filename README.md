# C4DI Coffee

A system to tell us how much coffee is left.

This system is unnecessarily obtuse. 

## System Overview

*  The system starts with reading the weight of the coffee pots in the kitchen.
* To weigh the pots we will be using a load cell connected to a load cell amplifier which is being read by an arduino.
*  The data read from the arduino is then read by a RaspberryPi through a serial connection to the arduino.
*  This data is then sent to a node.js web server through MQTT messaging service
*  The node.js server, running inside a docker container, inserts the data in a Postgresql database, which lives in another docker container. 
*  The data in the Postgres database is then read by a Phoenix based Elixir web server, also running in a docker container.
*  The Elixir web server then processes the data and makes it available via a RESTful API. 
*  There is then a web Unity front end displaying the currenct status of the coffe via a web browser.
*  The Phoenix server will also be sending data to Slack.


## Technology Count

1. Arduino
2. Raspberry Pi
3. Python
4. MQTT
5. Docker
6. Node
7. TypeScript
8. PostgreSQL
9. Elixir
10. Phoenix
11. Unity
