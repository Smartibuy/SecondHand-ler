SecondHand-ler
==

## Description
SecondHand-ler is a retriever for second-hand groups.

Usage
==
**install**
```shell
gem install secondHandler
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
