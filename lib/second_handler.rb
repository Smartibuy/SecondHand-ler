require 'koala'
require 'json'

module SecondHandler
  class FbGroupPost
    def initialize (access_token, group_id)
      @graph = Koala::Facebook::API.new(access_token)
      @group_id = group_id
    end

    def first_page
      @feed = @graph.get_connections(@group_id, "feed", :fields => ["attachments{media,subattachments{media}}","id","message","updated_time"])
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
        tmp = Hash.new
        tmp["id"] = item["id"]
        tmp["message"] = item["message"]
        tmp["updated_time"] = item["updated_time"]
        tmp["attachments"] = attachment_helper(item["attachments"])
        tmp
      end

    end

    private

    def attachment_helper (attach_hash)
      ok_data = []
      if attach_hash && attach_hash["data"].first["media"]
        ok_data << attach_hash["data"].first["media"]
      end
      if attach_hash && attach_hash["data"].first["subattachments"]
        attach_hash["data"].first["subattachments"].each do |item|
          ok_data << item
        end
      end
      ok_data
    end
  end
end
