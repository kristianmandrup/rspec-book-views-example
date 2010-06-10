require 'spec_helper'

module ApplicationHelper 
  def display_for(role) 
    yield if current_user.in_role?(role)
  end
end

describe ApplicationHelper do
  describe "#display_for(:role)" do
    context "when the current user has the role" do
      it "displays the content" do
        user = stub('User', :in_role? => true)
        helper.stub(:current_user).and_return(user)
        content = helper.display_for(:existing_role) {"content"}
        content.should == "content"
      end
    end   
    
    context "when the current user does not have the role" do
      it "does not display the content" do
        user = stub('User', :in_role? => false)
        helper.stub(:current_user).and_return(user)
        content = helper.display_for(:existing_role) {"content"}
        content.should == nil
      end
    end
    
  end
end