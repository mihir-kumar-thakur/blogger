class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :commentable_id
      t.string :commentable_type
      t.string :ancestry
      t.integer :user_id

      t.timestamps
    end

    add_index :comments, :ancestry
  end
end
