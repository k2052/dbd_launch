require 'delegate'

module Sinatra
  module Flash
    
    # A subclass of Hash that "remembers forward" by exactly one action. 
    # Tastes just like the API of Rails's ActionController::Flash::FlashHash, but with fewer calories.
    class FlashHash < DelegateClass(Hash)
      attr_reader :now, :next
      
      # Builds a new FlashHash. It takes the hash for this action's values as an initialization variable.
      def initialize(session)
        @now = session || Hash.new
        @next = Hash.new
        super(@now)
      end
      
      # We assign to the _next_ hash, but retrieve values from the _now_ hash.  Freaky, huh?  
      def []=(key, value)
        self.next[key] = value
      end
      
      # Swaps out the current flash for the future flash, then returns it.
      def sweep
        @now.replace(@next)
        @next = Hash.new
        @now
      end
      
      # Keep all or one of the current values for next time.
      def keep(key=nil)
        if key
          @next[key] = @now[key]
        else
          @next.merge!(@now)
        end
      end
      
      # Tosses any values or one value before next time.
      def discard(key=nil)
        if key
          @next.delete(key)
        else
          @next = Hash.new
        end
      end
    end
  end
end

module Sinatra
  module Flash
    module Storage
  
      # The main Sinatra helper for accessing the flash. You can have multiple flash collections (e.g.,
      # for different apps in your Rack stack) by passing a symbol to it.
      # 
      # @param [optional, String, Symbol] key Specifies which key in the session contains the hash
      # you want to reference. Defaults to ':flash'. If there is no session or the key is not found, 
      # an empty hash is used.  Note that this is only used in the case of multiple flash _collections_,
      # which is rarer than multiple flash messages.
      #
      # @return [FlashHash] Assign to this like any other hash.
      def flash(key='flash')     
        @flash ||= {}
        @flash[key] ||= FlashHash.new((session ? session[key] : {}))
      end
      
    end
  end
end  

module Sinatra
  module Flash
    module Style

      # A view helper for rendering flash messages to HTML with reasonable CSS structure. Handles 
      # multiple flash messages in one request. Wraps them in a <div> tag with id #flash containing
      # a <div> for each message with classes of .flash and the message type.  E.g.:
      #
      # @example
      #   <div id='flash'>
      #     <div class='flash info'>Today is Tuesday, April 27th.</div>
      #     <div class='flash warning'>Missiles are headed to destroy the Earth!</div>
      #   </div>
      #
      # It is your responsibility to style these classes the way you want in your stylesheets.
      #
      # @param[optional, String, Symbol] key Specifies which flash collection you want to display. 
      #   If you use this, the collection key will be appended to the top-level div id (e.g.,
      #   'flash_login' if you pass a key of  :login).  
      #
      # @return [String] Styled HTML if the flash contains messages, or an empty string if it's empty.
      def styled_flash(key='flash')     
        return "" if flash(key).empty?
        id = (key == 'flash' ? "flash" : "flash_#{key}")
        messages = flash(key).collect {|message| "  <div class='#{message[0]} message'>#{message[1]}</div>\n"}
        "<div class='#{id}'>\n" + messages.join + "</div>"
      end
      
    end
  end
end

module Sinatra
  module Flash
    
    def self.registered(app)
      app.helpers Flash::Storage
      app.helpers Flash::Style

      # This callback rotates any flash structure we referenced, placing the 'next' hash into the session
      # for the next request.
      app.after {@flash.each{|key, flash| session[key] = @flash[key].next} if @flash}
    end

  end
  
  register Flash
end