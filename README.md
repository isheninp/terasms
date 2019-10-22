## Terasms

### Description
Sending messages via Terasms

### Usage:
```ruby
require 'terasms'

Terasms.configure do |config|
    config.url = "https://auth.terasms.ru/outbox/send"
    config.login = "Your_user_name"
    config.password = "Passwd"
    config.sign = "your_token"
    config.sender = "Sender"
    config.type = "sms"
end

api = Terasms::Sms.new
result = api.send({target: "+77501112233", message: "Привет Мир! Тест рассылки смс"})
```
### License
MIT License. Copyright 2016-2017 isheninp@gmail.com
