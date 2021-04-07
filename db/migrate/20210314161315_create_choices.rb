class CreateChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :choices do |t|
      t.string :description
      t.integer :post_id
      t.integer :vote_count, default: 0
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
