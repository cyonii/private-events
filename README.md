# Private Event

This project is an platform where users can host an event and invite guests simliar to Eventbrite

## Overview
This project has `User` and `Event` models, and an `Invitation` table which serves as a through table to associate what `User` is invited to what `Event`

This is the simple representation of the Association between the `User`, `Event`, and `Invitation` models
```
class User < ApplicationRecord
  has_many :events, foreign_key: 'creator_id', class_name: 'Event'
  has_many :invitations
  has_many :invites, through: :invitations, source: :event
end


class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invitations, dependent: :destroy
  has_many :attendees, through: :invitations, source: :attendee
end


class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, foreign_key: :user_id, class_name: 'User'
end
```

## Live Demo
Checkout the live demo at [Live](https://eventery.herokuapp.com/)

## Built With
- Rails
- Bootstrap 5
- HTML
- CSS (SCSS)
- Database (SQLite3) for development


## Getting Started
To run the project in your local machine follow this step by step instruction:
1. Open your terminal and run `git clone git@github.com:cyonii/private-events.git`
2. Once the repo is cloned, navigate into it's directory with `cd private-events`
3. Run `bundle install` to install dependencies
4. Run `yarn install`
5. Run `rails db:migrate`
6. You can run `rails db:seed` to populate the database with fake data
7. After your run the previous operations, run `rails server`

## Contributing

Contributions, issues, and feature requests are welcome!
Feel free to check the [issues page](../../issues).

## Show your support

Give a ⭐️ if you like this project!

## Authors

👤 **CY Kalu**

- GitHub: [@cyonii](https://github.com/cyonii)
- Twitter: [@theOnuoha](https://twitter.com/theOnuoha)
- LinkedIn: [Silas Kalu](https://www.linkedin.com/in/cyonii/)
