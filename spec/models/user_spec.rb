require 'spec_helper'

describe User do
  describe "#send_message" do
    before(:each) do
      @zach = User.create! :subscription => Subscription.new
      @david = User.create!
    end

    it "asks the subscription if the user can send a message" do
      @zach.subscription.should_receive(:can_send_message?).with(@zach, Date.today)
      @zach.send_message(:title => "Book Update")
    end

    context "when the user is under their subscription limit" do
      before(:each) do
        @zach.subscription.stub!(:can_send_message?).and_return true 
      end

      it "sends a message to another user" do
        msg = @zach.send_message( 
          :title => "Book Update", 
          :text => "Beta 11 includes great stuff!",        
          :recipient => @david
        )
        @david.received_messages.should == [msg]
        msg.title.should == "Book Update" 
        msg.text.should == "Beta 11 includes great stuff!"        
      end

      it "adds the message to the sender's sent messages" do
        msg = @zach.send_message(
          :title => "Book Update", 
          :text => "Beta 11 includes great stuff!",
          :recipient => @david
        )
        @zach.sent_messages.should == [msg]      
      end      
    end  
    
    context "when the user is over their subscription limit" do 
      before(:each) do
        @zach.subscription.stub!(:can_send_message?).and_return false 
      end
            
      it "does not create a message" do
        lambda { 
          @zach.send_message(
            :title => "Book Update", 
            :text => "Beta 11 includes great stuff!",
            :recipient => @david
          )
        }.should_not change(Message, :count)
      end
    end
    
  end
end
