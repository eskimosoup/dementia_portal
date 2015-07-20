require 'rails_helper'

RSpec.describe CategoryPresenter, type: :presenter do
  let(:category) { build(:category) }
  let(:category_with_image) { build(:category_with_image) }

  it "should return the title" do
    presenter = CategoryPresenter.new(object: category, view_template: view)
    expect(presenter.title).to eq(category.title)
  end

  context "images" do
    it "should not return nil if has an image" do
      presenter = CategoryPresenter.new(object: category_with_image, view_template: view)
      expect(presenter.homepage_image).to be
    end

    it "should return nil if has no image" do
      presenter = CategoryPresenter.new(object: category, view_template: view)
      expect(presenter.homepage_image).to be_nil
    end
  end

end