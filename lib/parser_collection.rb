module FBParsers 

    @@basic_sell_parser = lambda do |message|
      price = nil
      title = nil
      message_body = nil
      price_regex = /NT\$([\d,\.]+)/
      lines = message.split("\n")
      if lines.length > 3
        unless price_regex.match(lines[1]).nil?
         
          price = price_regex.match(lines[1])[1]
        end
      end
      if not price.nil?
        
        {"price" => price.gsub(",","").to_i , "title" => lines[0] ,"message" => lines[3..-1].join("\n")}
      else
        raise ArgumentError, "message parse fail"
      end
      
    end
    @@tools = {
      "1730742887066429" => @@basic_sell_parser,
      "144498012423141" => @@basic_sell_parser,
      "107793636088378" => @@basic_sell_parser,
      "191505604299442" => @@basic_sell_parser,
      "815837461828111" => @@basic_sell_parser,
      "952367224814302" => @@basic_sell_parser,
      "373766972786317" => @@basic_sell_parser,
      "1049467665068019" => @@basic_sell_parser,
    }
    
    def self.message_parser (gid)
      @@tools[gid]
    end
    def self.message_parser_all
      @@tools
    end
  
end