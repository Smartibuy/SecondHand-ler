module FBParsers 

    @@parse_1730742887066429 = lambda do |message|
      price = nil
      title = nil
      message_body = nil
      price_regex = /NT\$([\d,\.]+)/
      lines = message.split("\n")
      if lines.length >= 3
        unless price_regex.match(lines[1]).nil?
          print price
          price = price_regex.match(lines[1])[1]
        end
      end
      if not price.nil?
        {"price" => price.gsub(",","").to_i , "title" => lines[0] ,"body" => lines[2..-1].join("\n")}
      else
        raise ArgumentError, "message parse fail"
      end
      
    end
    @@tools = {"1730742887066429" => @@parse_1730742887066429 }
    def self.message_parser (gid)
      @@tools[gid]
    end
  
end