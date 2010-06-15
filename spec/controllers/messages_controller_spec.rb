#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'spec_helper'

describe MessagesController, "POST create" do
  
  before(:each) do
    @message = mock_model(Message, :save => nil).as_null_object
    Message.stub(:new).and_return(@message)
  end

  it "creates a new message" do
    Message.should_receive(:new).
      with("text" => "a quick brown fox").
      and_return(@message)
    post :create, :message => { "text" => "a quick brown fox" }
  end

  # it "saves the message" do
  #   @message.should_receive(:save)
  #   post :create, :message => { "text" => "a quick brown fox" }
  # end

  context "when the message saves successfully" do
    before(:each) do
      @message.stub(:save).and_return(true)
    end
    
    it "sets a flash[:notice] message" do
      post :create, :message => { "text" => "a quick brown fox" }
      flash[:notice].should == "The message was saved successfully."
    end
    
    it "redirects to the messages index" do
      post :create, :message => { "text" => "a quick brown fox" }
      response.should redirect_to(messages_path)
    end
  end

  
  context "when the message fails to save" do
    before(:each) do
      @message.stub(:save).and_return(false)
      @message.stub(:new_record?).and_return(true)
    end
    
    it "assigns @message" do
      post :create, :message => { "text" => "a quick brown fox" }  
      assigns(:message).should eq(@message) 
    end

    it "renders the new template" do
      post :create, :message => { "text" => "a quick brown fox" }
      puts response.template.to_yaml
      # puts response.methods.sort
      # response.template.should redirect_to(new_message_path)
    end

  end
  

end



