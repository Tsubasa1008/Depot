module CurrentCount

  private
    def init_count
      session[:count] = 0
      @count = session[:count]
    end

    def set_count
      session[:count] += 1
      @count = session[:count]
    rescue 
      session[:count] = 1 if session[:count].nil?
      @count = session[:count]
    end

    def show_count_message
      if @count > 5
        @count_message = "You've been here " + @count.to_s + ' time'.pluralize(@count)
      else
        @count_message = nil
      end
    end
end