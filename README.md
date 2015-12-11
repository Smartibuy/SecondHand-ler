SecondHandler
==
SecondHandler is a retriever for second-hand information on Twitter and Facebook.  
[![Gem Version](https://badge.fury.io/rb/secondHandler.svg)](https://badge.fury.io/rb/secondHandler)

Usage
==
**install**
```shell
gem install secondHandler
```
**CLI**  
Tips: You can use :arrow_down: & :arrow_up: arrow key to fetch next/previous page.  
`Ctrl + C` to exit!
```shell
$ second_handler fb --token 'facebook_dev_access_token' --id 'public_group_id'
```
**Code Snippet**
```ruby
require 'second_handler'
fb = SecondHandler::FbGroupPost.new('access_token', 'group_id')
# fetch first page
page = fb.first_page
# get neat content
content = page.get_content
# get next page
page = page.next_page
```
**SecondHandler::FbGroupPost.get_content Hash sample**
```ruby
 {
  "id"=>"0000000_0000000", #feed id
  "message"=>"OOOO", 
  "updated_time"=>"2015-11-08T00:00:00+0000", 
  "attachments"=>[
    {"media"=>{"image"=>{"height"=>720, "src"=>"http://www.example.com", "width"=>420}}},
    {"media"=>{"image"=>{"height"=>720, "src"=>"http://www.example.com", "width"=>405}}}
  ], #post images
  "from"=>{
    "id"=>"000000000", #user's fbid
    "name"=>"My name", #user's fbname
    "picture"=>{"is_silhouette"=>false, "url"=>"http://www.example.com"} #user's profile picture
  }
 }
 ```
## License

![](https://img.shields.io/packagist/l/doctrine/orm.svg)
