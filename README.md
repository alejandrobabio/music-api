# Music API

About design and trade offs read the [ADR.md](docs/ADR.md)

### Development setup

1. Copy config/database.yml.example to config/database.yml and fill it with your development and test databases config
2. Run the server with `$ bundle exec rerun -- puma --port 3000 config.ru`
3. The api is served on localhost:3000
