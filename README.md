SecondHandler
==

## Description
SecondHandler is a retriever for second-hand information on Twitter and Facebook.

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
$ second_handler fb --token 'facebook_dev_access_token' --id '817620721658179'
# 817620721658179 is a Facebook group ID.  
```
**Code Snippet**
```ruby
require 'second_handler'
fb = SecondHandler::FbGroupPost.new(access_token, "group_id")
# fetch first page
page = fb.first_page
# get content
content = page.get_content
# get next page
page = page.next_page
```

## License

![](https://img.shields.io/packagist/l/doctrine/orm.svg)
