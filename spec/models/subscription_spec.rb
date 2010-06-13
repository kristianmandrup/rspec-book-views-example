require 'spec_helper'

describe Subscription do
  describe "#can_send_message?" do
    before(:each) do
      @subscription = Subscription.create!(:limit => 1)
      @user = User.create!(:subscription => @subscription)
    end

    context "when a user has not reached the subscription limit for the month" do
      it "returns true" do
        @subscription.can_send_message?(@user, Date.today).should be_true
      end
    end

    context "when a user has reached the subscription limit for the month" do
      it "returns false" do
        @user.sent_messages << Message.create!(
          :title => "foo",
          :text => "bar",
          :recipient => mock_model(User)
        )
        @subscription.can_send_message?(@user, Date.today).should be_false
      end
    end

  end
end
