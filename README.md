#Keto Tonight

Keto Tonight is a web app for recipes that fit the criteria for the ketogenic diet. Users are able to create recipes, which are checked with compliance with the diet before they are saved in the database. Recipes can also be searched for based on what a user has in their pantry. Each recipe features a detailed nutritional breakdown. 

##Installation

An up-to-date version of this app is hosted on Heroku, available at [Keto Tonight](https://stark-harbor-64502.herokuapp.com)

To set up a local instance of this web app, clone this repository. In the root of the application, run the following commands:

```
rails db:migrate
```

and 

```
rake db:migrate
```

This will set up the database and fill it with vital seed data. 

## Usage

Run the following command:

```
rails server
```

This will set up a local server hosting the web app. Navigate to [Local Host](tcp://0.0.0.0:3000) try it out!

## Development

Developed by Alexandra Wright during the Learn.co curriculum

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/f3mshep/keto_tonight. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
