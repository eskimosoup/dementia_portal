class CreateFrequentlyAskedQuestionCategories < ActiveRecord::Migration
  def change
    create_table :frequently_asked_question_categories do |t|
      t.belongs_to :frequently_asked_question, index: { name: "faq_categories_on_faq_id" }, foreign_key: true
      t.belongs_to :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
