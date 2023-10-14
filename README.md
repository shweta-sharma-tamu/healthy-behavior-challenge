# README

## Development Setup

1. Duplicate .env.template file and save in same location with name as .env
2. Run docker compose up
3. Go to the docker container service: 'web' (which is our rails container). Access it as terminal by docker exec command or docker desktop application.
4. Run bin/rails db:migrate

**Basic Architecture**
1. Docker starts starts 3 containers. 1 rails container and 2 DB containers
2. One DB container is when you are developing usually, and another is when you are running tests (check database.yml)

## Testing locally

0. Please make sure .env file is correct
1. Run your test commands in the terminal of rails container.
2. Run cucumber tests with `RAILS_ENV=test cucumber -s`
3. Run rspec tests with `RAILS_ENV=test rspec`
4. You can find coverage report in coverage/

Note that the test db is cleaned before every Scenario in Cucumber and describe block in rspec.