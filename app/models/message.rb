class Message < ActiveRecord::Base
  belongs_to :recipient, :class_name => User.name

  named_scope :in_date_range, lambda { |range|
    { :conditions => { :created_at => range } }
  }

  validates_presence_of :title, :text, :recipient
end