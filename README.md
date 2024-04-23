# moodledocker
simple dockerfile to start a moodle instance

# SETUP
clone the github repository of moodle (4.4) in a folder named /moodle placed in the root directory of the project
create a folder named moodledata in the root of the project

Modify config.php accordingly to the desired db
Modify config.sql if you wish to change the user and schema name for mysql
Modify dockercompose.yml to change the root user and pwd