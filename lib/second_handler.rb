require 'koala'
require 'json'

module SecondHandler
  class FbGroupPost
    def initialize (access_token, group_id)
      @graph = Koala::Facebook::API.new(access_token)
      @group_id = group_id
    end

   # return feed collecton , can get next page by content.next_page
   def content
      feed = @graph.get_connections(@group_id, "feed", :fields => ["message","attachments","updated_time","comments"])
    end
  end
end