class AddAuthorAvatarUrlColumnToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :author_avatar_url, :text
  end
end
