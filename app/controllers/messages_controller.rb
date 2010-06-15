class MessagesController < ApplicationController                 
  before_filter :login_required

  def new
    @message = Message.new
  end
  
  def create
    @message = current_user.send_message params[:message]
    if @message.new_record?
      render :action => "new"
    else
      flash[:notice] = "The message was saved successfully."
      redirect_to messages_path
    end
  end

  def current_user
    @user ||= User.create! :subscription => Subscription.create!(:limit => 1)
  end

  def login_required
  end
end
