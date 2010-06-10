#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'spec_helper'

describe "messages/new.html.erb" do
  before(:each) do
    assign(:message, mock_model(Message).as_null_object)
    assign(:recent_messages, [])
  end

  it_should_behave_like "a template that renders the messages/form partial"
  
#  it "renders the messages/form" do 
    # template.should_receive(:render).with(
    #   "form", 
    #   :message => assign(:message)
    # )
    # render
    # rendered.should render_template("form")
#  end

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
