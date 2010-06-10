class MessagesController < ApplicationController                 
  def create
    message = Message.new(params[:message])  
    message.save if message
  end
end
