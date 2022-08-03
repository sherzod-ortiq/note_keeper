# Note keeper

## Description
Note keeper app built with Ruby and Ruby on Rails.<br>
This app is built to experiment with Ruby and Ruby on Rails automated testing.<br>
[Best rails testing practices were followed.](https://betterprogramming.pub/how-to-set-up-rails-with-rspec-capybara-and-database-cleaner-aacb000070ef)<br>
App consists of 2 Docker containers: 1 - rails app, 2 - postgres database.<br>
**react-rails** gem is used for Reactjs.<br>
The volume binding is used in development to map container files and folders to host machine.<br>
Volume binding makes it possible to exclude files from mapping.<br>
There are separate Docker and Docker compose files for development and test environments.<br>

## Tech stack
Docker<br>
Docker compose<br>
Ruby<br>
Ruby on Rails<br>
React.js<br>

### Testing
rspec-rails<br>
factory_bot_rails<br>
database_cleaner<br>
selenium-webdriver<br>

## How to make it work

**For development environment:**<br>
cd to project root folder.<br>
We have 2 containers in development environment.<br>
Create images + create and run containers:<br>
`docker-compose -f ./docker-compose-dev.yml up`<br>
Stop and remove containers:<br>
`docker-compose -f ./docker-compose-dev.yml down`<br>
Rebuild images + create and run containers:<br>
`docker-compose -f ./docker-compose-dev.yml up --build`<br>
List services:<br>
`docker-compose -f ./docker-compose-dev.yml ps`<br>
App runs on *localhost:3000*<br>

**For test environment:**<br>
cd to project root folder.<br>
We have 4 containers in test environment.<br>
Create images + create and run containers:<br>
`docker-compose -f ./docker-compose-test.yml up`<br>
Stop and remove containers:<br>
`docker-compose -f ./docker-compose-test.yml down`<br>
Rebuild images + create and run containers:<br>
`docker-compose -f ./docker-compose-test.yml up --build`<br>
List services:<br>
`docker-compose -f ./docker-compose-test.yml ps`<br>
Container where tests are run may need to restart few times<br>
in order to connect to postgres.<br>
Don't forget to stop all the services after running tests.<br><br>
