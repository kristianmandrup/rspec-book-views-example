# Views example Recipe #

## Configure and Bundle Gems ##

<code>$ mate Gemfile</code>
    
<pre>source 'http://rubygems.org'

gem 'rails', '3.0.0.beta3'

gem 'sqlite3-ruby', :require => 'sqlite3'

# Bundle gems for certain environments:
group :test do
  gem "rspec-rails",        ">= 2.0.0.beta.11", :git => "git://github.com/rspec/rspec-rails.git"
  gem "rspec-spies",        ">= 1.2.9"
  gem "rspec",              ">= 2.0.0.beta.11", :git => "git://github.com/rspec/rspec.git"
  gem "rspec-core",         ">= 2.0.0.beta.11", :git => "git://github.com/rspec/rspec-core.git"
  gem "rspec-expectations", ">= 2.0.0.beta.11", :git => "git://github.com/rspec/rspec-expectations.git"
  gem "rspec-mocks",        ">= 2.0.0.beta.11", :git => "git://github.com/rspec/rspec-mocks.git"
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails',     ">=0.3.2"
  gem 'cucumber',           '>=0.8.0'
  gem 'spork'
  gem 'launchy'  
end
</pre>

<code>$ bundle install</code>

## Configure RSpec 2 ##

<code>$ rails g rspec:install</code>

## Create View spec for messages/show ##

<code>$ rails g rspec:view messages show</code>

<code>$ rspec spec/views/messages/show.html.erb_spec.rb </code>

*messages/show.html.erb_spec.rb*
<pre>require 'spec_helper'
describe "messages/show.html.erb" do
  it "displays the text attribute of the message" do
    render
    rendered.should contain("Hello world!")
  end
end 
</pre>

## Create View for messages/show ##

*app/views/messages/show.html.erb*
<pre>
Hello world!
</pre>

<code>$ rspec spec/views/messages/show.html.erb_spec.rb </code>

## Refactor View spec ##

*messages/show.html.erb_spec.rb*
<pre>
describe "messages/show.html.erb" do
  it "displays the text attribute of the message" do
    assign(:message, stub("Message", :text => "Hello world!")) # added!
    render
    rendered.should contain("Hello world!")
  end
end 
</pre>

## Refactor View ##
                                                                  
*app/views/messages/show.html.erb*
<pre>
<%=@message.text %>
</pre>

<code>$ rspec spec/views/messages/show.html.erb_spec.rb </code>   

## Create View Spec messages/new ##

<code>$ rails g rspec:view messages new</code>

*messages/new.html.erb_spec.rb*
<pre>
  require 'spec_helper'

  describe "messages/new.html.erb" do
    it "renders a form to create a message" do
      assign(:message, stub("Message"))
      render
      rendered.should have_selector("form",
        :method => "post",
        :action => messages_path
      ) do |form|
        form.should have_selector("input", :type => "submit")
      end
    end
  end
</pre>

<code>$ rspec spec/views/messages/new.html.erb_spec.rb </code>

## Create View for messages/new ##

<pre>
  <%= form_for @message do |f| %> 
    <%= f.submit "Save" %>
  <% end %>  
</pre>                        

<code>$ rspec spec/views/messages/new.html.erb_spec.rb </code>

## Refactor View spec ##

class Message; end

*messages/new.html.erb_spec.rb*
<pre>
  describe "messages/new.html.erb" do
    it "renders a form to create a message" do
      assign(:message, mock_model(Message).as_new_record)
      render
      rendered.should have_selector("form",
        :method => "post",
        :action => messages_path
      ) do |form|
        form.should have_selector("input", :type => "submit")
      end
  end
</pre>

<code>$ rspec spec/views/messages/new.html.erb_spec.rb </code>

## Add REST resource messages ##

*routes.rb*
<pre>
  ViewsExample::Application.routes.draw do |map|
    resources :messages
    ...
</pre>
     

# Controllers #

<code>$ rails g rspec:controller messages</code>

Or even better

<code>$ rails g controller messages</code>

<pre>
  require 'spec_helper'

  describe MessagesController, "POST create" do 
    it "creates a new message" 
    it "saves the message" 
  end
</pre>                     

## Implement view spec ##

<pre>
  describe MessagesController, "POST create" do

    it "creates a new message" do
      Message.should_receive(:new).with("text" => "a quick brown fox")
      post :create, :message => { "text" => "a quick brown fox" }
    end

    it "saves the message" do
      message = mock_model(Message)
      Message.stub(:new).and_return message
      message.should_receive(:save)
      post :create
    end

  end  
</pre>

