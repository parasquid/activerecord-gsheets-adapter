# Activerecord::Gsheets::Adapter

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/activerecord/gsheets/adapter`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-gsheets-adapter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-gsheets-adapter

## Usage

Use it just like any other ActiveRecord adapter, with a few caveats.

### Mapping

| RDBMS    | Google Sheets |
|----------|---------------|
| database | spreadsheet   |
| table    | worksheet     |
| row      | list_row + 1  |
| column   | list_row[0]   |
|          | cell          |

We're using the first row of the sheet as the column headers.

### Getting the an OAuth token from Google

In order to make operations on a Google Spreadsheet you will need an authentication token. There is a sample console OAuth token generator available in ActiveRecord::Gsheets::Oauth

```ruby
  authenticator = Gsheets::Oauth::Offline.new(CLIENT_ID, CLIENT_SECRET)
  uri = authenticator.get_authentication_uri

  # open uri.to_s in your browser and copy the code

  code = $stdin.gets.chomp
  access_token = authenticator.get_access_token(authentication_code: code)
  refresh_token = authenticator.get_refresh_token(authentication_code: code)

  # or alternatively, if you already have a refresh token:
  # access_token = authenticator.get_access_token(refresh_token: refresh_token)
```

### Configuration

Save the configuration either in an environment variable or (not recommended) directly in your `database.yml` file:

```yaml
development:
  document: "google document id"
  client_id: ENV["GOOGLE_CLIENT_ID"]
  client_secret: ENV["GOOGLE_CLIENT_SECRET"]
  refresh_token: ENV["GOOGLE_REFRESH_TOKEN"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/parasquid/activerecord-gsheets-adapter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

