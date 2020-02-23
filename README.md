[![Codeship Status for dovakeen118/naruto_pundit](https://app.codeship.com/projects/d6128a10-2fcc-0138-f6f0-3ade278cb526/status?branch=master)](https://app.codeship.com/projects/385135)

# Naruto Pundit

This application is an example of how to implement the Pundit Ruby gem for user authorization.\
The `master` branch is a work in progress to incorporate new technologies.\
The `starter-code` branch does not include Pundit - it is where you can start to add your roles for authorization.\
The `add-user-roles` branch includes Pundit policies for both Users and Missions.

Pundit repository: https://github.com/varvet/pundit

## Setup
```
Ruby version 2.4.5
Rails version 5.2.3
Bundler version 2.0.2
```

## Getting Started
After you fork, clone, or download the repo, execute the following commands to run the application locally:
```
$ bundle
```

To build the PostgreSQL database:
```
$ bundle exec rails db:create
$ bundle exec rails db:migrate
```

To view the app in development locally at https://localhost:3000/
In a separate terminal window run the following:
```
$ rails s
```
