require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  before do
    @page = Page.create(title: "The title", content: "The content") 
  end
  
  describe "GET #show" do
    it "returns http success" do
      get :show, id: @page
      expect(response).to have_http_status(:success)
    end
  end
end
