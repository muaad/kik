# Kik

Build Kik bots with Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kik'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kik

## Usage

Create a Kik bot at [dev.kik.com](https://dev.kik.com/) and copy your bot name and API key.

Initialize the `Kik::Client`
	
```ruby
client = Kik::Client.new 'bot_name', 'api_key'
```

### Set webhook

```ruby
client.set_webhook 'url'
```

You can specify some settings like whether you want to send/receive read receipts, delivery receipts or typing notification.

```ruby
client.set_webhook 'url', { "manuallySendReadReceipts" => false, "receiveReadReceipts" => false, "receiveDeliveryReceipts" => false, "receiveIsTyping" => false }
```

### Send messages

Kik requires that a bot doesn't initiate a conversation with a user. When a user sends your bot a message, it will receive the `chat_id` which you can use to reply to the message.

```ruby
client.messages.send_text('user_name', 'chat_id', 'message')
```

You can add a keyboard to your message. Pass in the keyboard as an array containing a list of the elements that make up the keyboard. The `boolen` argument at the end is for toggling the keyboard ON or OFF.

```ruby
client.messages.send_text('user_name', 'chat_id', 'Are you a human being?', ["Yes", "No"], true)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/muaad/kik.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

