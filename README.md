# Saving Goals Assignment
#### _An Api Application to add Saving Goals_
- User can Signup/ Login
- User can create Saving Goals

## Development
- This is a Ruby(2.7.3) on Rails(6.1.4) API only application.
- The database used is SQLite3.
- The application uses Rspec for test cases.

After cloning the repository. Execute the following steps in terminal.
```sh
cd <path-to-repo>
bundle install
rake db:create
rake db:migrate
rake db:seed # This will seed some sample data
rails s # rails server
```
Your server will start at ```http://localhost:3000```

## Schema
- User
  - has_many Goals
- Goal
  - belongs_to User

## Testing
Test Cases are written using Rspec (with Faker, FactoryBot).
To run test cases on file(s) ```rspec .``` or ```rpsec spec/<filename>```

## API Endpoints
#### USERS
Users#Create - Signup a User
```
# POST http://localhost:3000/auth/signup
Body => {
  "user": {
    "username": "huzaifa",
    "password": "Huzaifa@18"
  }
}
```

#### SESSIONS
Sessions#Create - Login a User (Session using JWT)
```
# POST http://localhost:3000/auth/login
Body => {
  "username": "huzaifa",
  "password": "Huzaifa@18"
}
```

#### GOALS
Goals#Create - Create a goal
```
# POST http://localhost:3000/goals
Headers => {
  "Authorization": <JWT Token>
}

Body => {
  "goal": {
    "description": "My First Goal",
    "amount": "123.45",
    "target_date": "2021-12-31"
  }
}
```

Goals#Update - Update an existing goal
```
# PUT http://localhost:3000/goals/:id
Headers => {
  "Authorization": <JWT Token>
}

Body => {
  "goal": {
    "description": "Editing My First Goal",
    "amount": "543.21",
    "target_date": "2022-12-31"
  }
}
```
