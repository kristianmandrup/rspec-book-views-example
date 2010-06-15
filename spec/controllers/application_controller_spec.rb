require 'spec_helper'

describe ApplicationController, "handling AccessDenied exceptions" do
    
  class FooController < ApplicationController
    def index
      raise AccessDenied
    end
  end
  
  subject { FooController }

  it "redirects to the /401.html (access denied) page" do
    pending("RSpec 2 guidelines")    
    get :index
    response.should redirect_to('/401.html')
  end
end
