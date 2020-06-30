class CreateBlogPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_posts do |t|

      t.string   :title,                      null: false
      t.text     :introduction,               null: false
      
      t.text     :content_in_text,            null: false
      t.text     :content_in_html,            null: false
      t.text     :content_in_json,            null: false


      t.string   :editor,                     null: false
      t.string   :type,                       null: false

      t.timestamps
    end
  end
end
