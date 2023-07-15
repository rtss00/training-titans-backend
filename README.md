# Training Titans Backend implementation

Training Titans is an application developed as part of the 2nd Hackathon held at Arionkoder. It is a platform where people can train their skills to become better technical interviewers, leveraging the capabilities of generative AI.

# Development Setup

## Prior comments

- The project runs on Ruby 3.0.3.
- The project depends on PostgreSQL. Make sure you have the correct libs to support it.
- The project is only meant to run locally. There's no production support available.

## Running locally

### Dependencies

First, install the dependencies:
```bash
bundle install
```
Common failure points are: 
- Not having the correct Ruby version installed. Make sure you have a manager installed.
- Not having PostgreSQL installed or properly configured. If you're running on macOS, check you have a PostgreSQL interface available in your path. You can install `postgres` or `libpq` using `brew`. 

### Credentials

Project secrets are held securely in this file: `config/credentials.yml.enc`. This includes the postgres development access credentials. In case you need to create your own, it has the following format:
```yml
# PostgreSQL database password
database:
  user: "<YOUR_KEY_HERE>"
  password: "<YOUR_KEY_HERE>"

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: <YOUR_KEY_HERE>
```

### Database setup

After configuring your credentials, run the following commands, in order.

```bash
# This will create the database
bundle exec rails db:create
# This will load the schema into database
bundle exec rails db:schema:load
# This loads test data into the database
bundle exec rails db:seed
```

After this, you can interact with the Rails console with `rails c`, or run the server with `rails s`.

## Running tests

The project has RSpec configured. You can run tests with the following command:
```bash
bundle exec rspec
```

## Admin

The project also comes with an administrator configured running on ActiveAdmin. You can access it in the `/admin` route. The credentials are defined in the seed file. The creation of some resources can only be done from the admin.
