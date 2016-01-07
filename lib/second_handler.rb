require 'koala'
require 'json'
require_relative 'fb_data_handler'
require_relative 'parser_collection'

module SecondHandler
  def self.read_parsed_info(access_token)
    graph = Koala::Facebook::API.new(access_token)
    graph.batch do |batch_api|
      FBParsers.message_parser_all.each_key do |key|
        batch_api.get_object(key)
      end
    end
  end
  
  class FbSinglePost
    include FbDataHandler
    
    
    def initialize (access_token, post_id)
      @graph = Koala::Facebook::API.new(access_token)
      @post_id = post_id
    end
    def get_post_basic
      @basic = @graph.get_object(@post_id, :fields =>[
        "attachments{media,subattachments{media}}",
        "id",
        "message",
        "updated_time",
        "from{id,name,picture}",
        "comments.summary(1)",
        "likes.summary(1)"
      ])
      clean_post_content(@basic)
    end
    
    def first_comment
      @comment = @graph.get_connections(@post_id, "comments",
        :limit=>1,
        :fields => ["from{name,id,picture}",
          "id",
          "message",
          "created_time",
          "like_count", 
        ]
      )
    end
    # 
    # Get specified page comment
    # == Parameters:
    # token::
    #   paging token
    # actions::
    #   canbe :before or :after
    #
    def specified_comment(token, action)
      @comment = @graph.get_connections(@post_id, "comments",
        :limit=>1,
        :fields => ["from{name,id,picture}",
          "id",
          "message",
          "created_time",
          "like_count", 
        ],
        action => token,
      )
    end
    
    
    
    def get_comment
      @comment.map do |single_comment|
        clean_comment(single_comment)
      end
    end
    
    def next_page_comment_params
      @comment.next_page_params
    end

    def previous_page_comment_params
      @comment.previous_page_params
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
    
    FB_POSTS_FIELDS = [
      "attachments{media,subattachments{media}}",
      "id",
      "message",
      "updated_time",
      "from{id,name,picture}",
      "comments.summary(1)",
      "likes.summary(1)"
    ]

    def initialize (access_token, group_id)
      @graph = Koala::Facebook::API.new(access_token)
      @group_id = group_id
      @message_parser = FBParsers.message_parser @group_id 
    end

    def first_page(page_token=nil,until_stamp=nil)
      @feed = @graph.get_connections(@group_id, "feed",:fields => FB_POSTS_FIELDS )
    end
    
    def specified_page (page_token,until_stamp=nil,since_stamp=nil)
      
      @feed = @graph.get_connections(@group_id, "feed",
        :__paging_token => page_token,
        :until => until_stamp,
        :since => since_stamp,
        :fields => FB_POSTS_FIELDS
        )
    
    end
    def next_page
      @feed = @feed.next_page
    end
    
    def next_page_params
      @feed.next_page_params
    end 
    
    def previous_page_params
      @feed.previous_page_params
    end 
    
    def previous_page
      @feed = @feed.previous_page
    end

    # return feed of current page  infomation , including image
    def get_content (&func)
      data = Array.new
      @feed.to_a.each do |single_post|
        begin
          data << clean_post_content(single_post, &@message_parser)
        rescue
        end
      end
      data
    end
    
    
  end
  
end
