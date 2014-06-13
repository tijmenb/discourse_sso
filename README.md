# DiscourseSSO

SSO for Discourse. Take a look [at the official thread](https://meta.discourse.org/t/official-single-sign-on-for-discourse/13045) for more info.

## Usage

```ruby
# initializers/discourse_sso.rb
DiscourseSSO::Config.configure do |config|
  config.secret = ENV['DISCOURSE_SSO_SECRET']
  config.return_url_base = "http://discuss.example.com/session/sso_login"
end

# app/controllers/sso_controller.rb
def authenticate
  sso = DiscourseSSO::Request.new(params[:sso], params[:sig])

  sso.user = {
    name: "sam",
    username: "samsam",
    email: "test@test.com",
    external_id: "hello123",
  }

  redirect_to sso.callback_url
end
```

## Installation

In your Gemfile:

    gem 'discourse_sso', github: 'tijmenb/discourse_sso'

## Contributing

1. Fork it ( https://github.com/[my-github-username]/discourse_sso/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
