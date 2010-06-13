class MessagesController < ApplicationController                 
  def create
    @message = Message.new(params[:message])
    if @message.save
      flash[:notice] = "The message was saved successfully."
      redirect_to messages_path
    else
      render :action => "new"
    end
  end
end
