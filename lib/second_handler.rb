require 'koala'
require 'json'
require_relative 'fb_data_handler'

module SecondHandler
  
  class FbSinglePost
    FB_POSTS_FIELDS = ["attachments{media,subattachments{media}}","id","message","updated_time","from{id,name,picture}", ]
    include FbDataHandler
    
    
    def initialize (access_token, post_id)
      @graph = Koala::Facebook::API.new(access_token)
      @post_id = post_id
    end
    def get_post_basic
      @basic = @graph.get_object(@post_id, :fields => FB_POSTS_FIELDS)
      clean_post_content(@basic)
    end
    
    def first_comment
      @comment = @graph.get_connections(@post_id, "comments", :fields => ["from{name,id,picture}","id","message","created_time","like_count", ])
    end
    
    def get_comment
      @comment.map do |single_comment|
        clean_comment(single_comment)
      end
    end
    def next_page_comment
      @comment = @comment.next_page
    end

    def previous_page_comment
      @comment = @comment.previous_page
    end
    
  end
  
  class FbGroupPost
    include FbDataHandler
    
    FB_POSTS_FIELDS = ["attachments{media,subattachments{media}}","id","message","updated_time","from{id,name,picture}", ]

    def initialize (access_token, group_id)
      @graph = Koala::Facebook::API.new(access_token)
      @group_id = group_id
    end

    def first_page
      @feed = @graph.get_connections(@group_id, "feed", :fields => FB_POSTS_FIELDS)
    end

    def next_page
      @feed = @feed.next_page
    end

    def previous_page
      @feed = @feed.previous_page
    end

    # return feed of current page  infomation , including image
    def get_content (&func)
      @feed.map do |single_post|
        clean_post_content(single_post)
      end
    end
    
    
  end
  
end
