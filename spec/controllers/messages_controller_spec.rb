#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'spec_helper'

class Message
end

describe MessagesController, "POST create" do
  
  it "creates a new message" do
    Message.should_receive(:new).with("text" => "a quick brown fox")
    post :create, :message => { "text" => "a quick brown fox" }
  end
  
  it "saves the message" do
    message = mock_model(Message).as_null_object 
    Message.stub(:new).and_return message
    message.should_receive(:save)
    post :create
  end

end


