require 'spec_helper'

describe "messages/edit.html.erb" do
  before(:each) do
    assign(:message, mock_model(Message).as_null_object)
    assign(:recent_messages, [])
  end

  it_should_behave_like "a template that renders the messages/form partial"
    # <%= render "form", :message => @message %>    
    # _view.should_receive(:render).with(
    #   :partial => "form",
    #   :locals => { :message => @message }
    # )  
    # render
  # end
end
