class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :description
      t.integer :user_id
      t.string :visibility, default: ""
      t.string :who_can_see, default: ""
      t.integer :vote_count, default: 0
      t.string :location
      
      t.string :existingtime, default: ""
      t.integer :close, default: 0
      t.string :hash_tags, default: ""
      
      t.timestamps
    end
  end
end
