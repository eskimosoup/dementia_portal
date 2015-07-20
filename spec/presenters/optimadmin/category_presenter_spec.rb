require 'rails_helper'

RSpec.describe Optimadmin::CategoryPresenter, type: :presenter do
  let(:category) { build(:category) }
  it "should return the title" do
    presenter = Optimadmin::CategoryPresenter.new(object: category, view_template: view)
    expect(presenter.title).to eq(category.title)
  end
end