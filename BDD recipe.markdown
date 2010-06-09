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
