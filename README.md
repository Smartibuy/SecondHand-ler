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
# fetch first page (you **must** call this function first if you want to read posts)
page = fb.first_page
# get current content
content = fb.get_content
# get next page
page = fb.next_page

fbp = SecondHandler::FbSinglePost.new('access_token', 'post_id')
fbp.get_post_basic   #get post information

fbp.first_comment    #fetch first comments
fbp.get_comment    #get current page comments
fbp.next_page_comment    #fetch next page comments
fbp.previous_page_comment    #fetch previous page comments



```
**SecondHandler::FbGroupPost.get_content Hash sample**
```ruby
 [{
  "id"=>"0000000_0000000", #feed id
  "message"=>"OOOO", 
  "updated_time"=>"2015-11-08T00:00:00+0000", 
  "attachments"=>[
     {"height"=>720, "src"=>"", "width"=>405},...
  ], #post images
  "from"=>{
    "id"=>"000000000", #user's fbid
    "name"=>"My name", #user's fbname
    "picture"=>{"is_silhouette"=>false, "url"=>"http://www.example.com"} #user's profile picture
  }
 },....]
 ```
**SecondHandler::FbSinglePost.get_post_basic Hash sample**
```ruby
{
  "id"=>"0000000_0000000", #feed id
  "message"=>"OOOO", 
  "updated_time"=>"2015-11-08T00:00:00+0000", 
  "attachments"=>[
     {"height"=>720, "src"=>"", "width"=>405},...
  ], #post images
  "from"=>{
    "id"=>"000000000", #user's fbid
    "name"=>"My name", #user's fbname
    "picture"=>{"is_silhouette"=>false, "url"=>"http://www.example.com"} #user's profile picture
  }
}
```
**SecondHandler::FbSinglePost.get_comment Hash sample**
```ruby
[{
    "id"=>"",
    "message"=>"",
    "created_time"=>"",
    "from"=>{"id"=>"",
    "name"=>"",
    "picture"=>{"is_silhouette"=>false, "url"=>""}},
    "like_count"=>0
},.....] 


```

CHANGELOG
===
2016-1-5 bump to v1.0.0
- add single post comment func
- modify `SecondHandler::FbGroupPost.get_content`  output (no backward support!!!)


## License

![](https://img.shields.io/packagist/l/doctrine/orm.svg)
