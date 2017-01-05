class CreateArticleCategory < ActiveRecord::Migration[5.0]
  def change
    create_table :article_categories do |t|
      t.references :category
      t.references :article
    end
  end
end
