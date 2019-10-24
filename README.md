## Terasms

### Description
Sending messages via Terasms

### Usage:
```ruby
require 'terasms'

Terasms.configure do |config|
    config.url = "https://auth.terasms.ru/outbox/send/json"
    config.balance_url = "https://auth.terasms.ru/outbox/balance/json/"
    config.status_url = "https://auth.terasms.ru/outbox/getstatus/json"
    config.login = "Your_user_name"
    config.password = "Passwd"
    config.sign = "your_token"
    config.sender = "Sender"
    config.type = "sms"
end

api = Terasms::Sms.new

puts api.balance # => {"status"=>"success", "result"=>{"status"=>0, "status_description"=>"OK", "balance"=>-36534.651, "pay_type"=>"after"}}

message = api.send({target: "+77501112233", message: "Hello Yarkiy world!"}) 

# =>
{"status"=>"success",
 "result"=>
  {"status"=>0,
   "status_description"=>"OK",
   "message_infos"=>
    [{"msisdn"=>"+79500466321", "id"=>"1042924450", "status"=>0, "price"=>0}]},
 "id"=>"1042924450"}

message_id =  message["id"] # => 1042924450

puts "Message status: #{api.status(1042924450)}" #=> {"result"=>"success", "status"=>"12", "status_desc"=>"delivered"}

```
### License
MIT License. Copyright 2019 Pavel Ishenin / isheninp@gmail.com
