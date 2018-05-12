class AddAuthorToArticles < ActiveRecord::Migration[5.2]
  def change
  	add_reference :articles, :author
  	add_foreign_key :articles, :users, column: :author_id
  end
end
