require 'spec_helper'

describe Score::Admin::OrganizationsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

end
