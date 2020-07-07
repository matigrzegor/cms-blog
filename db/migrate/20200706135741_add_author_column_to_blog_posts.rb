class AddAuthorColumnToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :author_username, :string, null: false
  end
end
