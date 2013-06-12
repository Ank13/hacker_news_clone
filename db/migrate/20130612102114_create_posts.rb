class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.string :text
      t.references :user
      t.timestamps
    end
  end
end

# Add validations for either (URL + Title) OR (Text + Title)
