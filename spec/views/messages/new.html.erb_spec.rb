#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'spec_helper'

class Message; end

describe "messages/new.html.erb" do   
  before(:each) do
    @message = mock_model(Message, :title => "the title").as_new_record.as_null_object 
    assign(:message, @message) 
    assign(:recent_messages, [])
  end  

  it "renders a form to create a message" do render
    rendered.should have_selector("form", 
      :method => "post", 
      :action => messages_path
    ) do |form| 
      form.should have_selector("input", :type => "submit")
    end
  end

  it "renders a form to create a message" do   
    @message.stub(:title).and_return("the title")
    render 
    rendered.should have_selector("form") do |form|
      form.should have_selector("input", 
        :type => "text", 
        :name => "message[title]", 
        :value => "the title"
      )
    end  
  end
  
  it "renders a text area for the message text" do
    @message.stub(:text).and_return("the message")    
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("textarea", 
        :name => "message[text]", 
        :content => "the message"
      )
    end    
  end

  it "renders recent messages" do
    assign(:recent_messages, [
      mock_model(Message, :text => "Message 1").as_null_object,
      mock_model(Message, :text => "Message 2").as_null_object
    ])
    render
    rendered.should have_selector(".recent_messages") do |sidebar|
      sidebar.should have_selector(".message", :content => "Message 1")
      sidebar.should have_selector(".message", :content => "Message 2")
    end
  end
  
end
