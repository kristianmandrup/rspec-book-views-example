require 'spec_helper'

describe "messages/show.html.erb" do
  it "displays the text attribute of the message" do
    assign(:message, stub("Message", :text => "Hello world!"))
    render
    rendered.should contain("Hello world!")
  end
end

