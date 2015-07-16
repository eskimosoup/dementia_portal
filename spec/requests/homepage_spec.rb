require 'rails_helper'

RSpec.describe "Home Page", type: :request do
  describe "GET /" do
    it "accesses the home page" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
