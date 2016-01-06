module FbDataHandler
    FACEBOOK_URL = "https://www.facebook.com"
    private
    def attachment_helper (attach_hash, &func)
      
      clean_data = []
      
      if attach_hash && attach_hash["data"].first["media"] && attach_hash["data"].first["media"]["image"]
        clean_data << attach_hash["data"].first["media"]["image"]
      end
      if attach_hash && attach_hash["data"].first["subattachments"] && attach_hash["data"].first["subattachments"]["data"]
        attach_hash["data"].first["subattachments"]["data"].each do |item|
          if item["media"] && item["media"]["image"]
            clean_data << item["media"]["image"]
          end
        end
      end
      clean_data
    end

    def clean_post_content (item)
      {
        "id" => item["id"],
        "origin_url" => FACEBOOK_URL+"/"+item["id"],
        "message" => item["message"],
        "updated_time" => item["updated_time"],
        "attachments" => attachment_helper(item["attachments"]),
        "from" => {
          "id" => item["from"]["id"],
          "name" => item["from"]["name"],
          "picture" => item["from"]["picture"]["data"],
        },
        "like_count"=> item["likes"]["summary"]["total_count"],
        "comment_count"=> item["comments"]["summary"]["total_count"],
    
      }
    end
    
    def clean_comment(item)
      {
        "id" => item["id"],
        "message" => item["message"],
        "created_time" => item["created_time"],
        "from" => {
          "id" => item["from"]["id"],
          "name" => item["from"]["name"],
          "picture" => item["from"]["picture"]["data"],
        },
        "like_count" => item["like_count"]
    
      }
    end
end