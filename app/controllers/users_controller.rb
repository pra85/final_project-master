class UsersController < ApplicationController
  def show

    @rss_link ||= "<link rel=\"alternate\" type=\"application/rss+xml\" " <<
      "title=\"RSS 2.0\" href=\"/comments.rss" <<
      (@user ? "?token=#{@user.rss_token}" : "") << "\" />"

    @showing_user = User.find_by_username!(params[:id])
    @heading = @title = "User #{@showing_user.username}"

 respond_to do |format|
      format.html { render :action => "show" }
      format.rss {
        if @user && params[:token].present?
          @title += " - Private feed for #{@user.username}"
        end

        render :action => "rss", :layout => false
      }
      format.json { render :json => @showing_user }
    end
  end

  def apishow
    @showing_user = User.find_by_username!(params[:id])   
    
      if params[:callback]
        render json: {:user => @showing_user}.to_json, :callback => params[:callback]
      else
        render json: {:user => @showing_user}.to_json
      end    
  end

  def tree
    @title = "Users"

    parents = {}
    karmas = {}
    User.all.each do |u|
      (parents[u.invited_by_user_id.to_i] ||= []).push u
    end

    Keystore.find(:all, :conditions => "`key` like 'user:%:karma'").each do |k|
      karmas[k.key[/\d+/].to_i] = k.value
    end

    @tree = []
    recursor = lambda{|user,level|
      if user
        @tree.push({ :level => level, :user_id => user.id,
          :username => user.username, :karma => karmas[user.id].to_i,
          :is_moderator => user.is_moderator?, :is_admin => user.is_admin? })
      end

      # for each user that was invited by this one, recurse with it
      (parents[user ? user.id : 0] || []).each do |child|
        recursor.call(child, level + 1)
      end
    }
    recursor.call(nil, 0)

    @tree
  end

  def invite
    @title = "Pass Along an Invitation"
  end
end
