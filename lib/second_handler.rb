require 'koala'
require 'json'

module SecondHandler
  class FbGroupPost
    def initialize (access_token, group_id)
      @graph = Koala::Facebook::API.new(access_token)
      @group_id = group_id
    end

    def first_page
      @feed = @graph.get_connections(@group_id, "feed", :fields => ["attachments{media,subattachments{media}}","id","message","updated_time","from{id,name,picture}"])
    end

    def next_page
      @feed = @feed.next_page
    end

    def previous_page
      @feed = @feed.previous_page
    end

    # return feed of current page  infomation , including image
    def get_content
      @feed.map do |item|
        {
          "id" => item["id"],
          "message" => item["message"],
          "updated_time" => item["updated_time"],
          "attachments" => attachment_helper(item["attachments"]),
          "from" => {
            "id" => item["from"]["id"],
            "name" => item["from"]["name"],
            "picture" => item["from"]["picture"]["data"],
          }
        }
      end

    end

    private

    def attachment_helper (attach_hash)
      ok_data = []
      
      if attach_hash && attach_hash["data"].first["media"]
        ok_data << attach_hash["data"].first["media"]
      end
      if attach_hash && attach_hash["data"].first["subattachments"] && attach_hash["data"].first["subattachments"]["data"]
        attach_hash["data"].first["subattachments"]["data"].each do |item|
          ok_data << item
        end
      end
      ok_data
    end
  end
end
