require 'spec_helper'

describe "messages/_form.html.erb" do
  before(:each) do
    @message = mock_model(Message, :title => "the title").as_null_object 
  end  

  context "when the message is a new record" do
    it "renders a form to create a message" do 
      render "messages/form", :message => @message.as_new_record
      rendered.should have_selector("form", 
        :method => "post", 
        :action => messages_path
      ) do |form| 
        form.should have_selector("input", :type => "submit")
      end
    end
  end

  context "when the message is an existing record" do
    it "renders a form to update a message" do
      render "messages/form", :message => @message
      rendered.should have_selector("form",
        :method => "post",
        :action => message_path(@message)
      ) do |form|
        form.should have_selector("input", :type => "submit")
      end
    end
  end


  it "renders a form to create a message" do   
    @message.stub(:title).and_return("the title")
    render "messages/form", :message => @message
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
    render "messages/form", :message => @message
    rendered.should have_selector("form") do |form|
      form.should have_selector("textarea", 
        :name => "message[text]", 
        :content => "the message"
      )
    end    
  end
end
