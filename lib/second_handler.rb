require 'koala'
require 'json'

module SecondHandler
  class SecondHandlerClass
    def initialize
      # A methods should be implemented.
    end

    def content
      @content ||= extract_information
    end

    private

    def extract_information
      # A methods should be implemented.
    end
  end
end
