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

1. Run your test commands in the terminal of rails container.
2. If the command starts test environment in rails, such as bundle exec rails test, it will access postgres_test service.