class Subscription < ActiveRecord::Base     
  
  def can_send_message?(user, date)
    range = date.beginning_of_month .. date.end_of_month
    number_sent = user.sent_messages.in_date_range(range).count
    number_sent < limit
  end
end
