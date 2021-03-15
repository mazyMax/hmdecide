class CreateChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :choices do |t|
      t.string :description
      t.integer :topic_id
      t.integer :count

      t.timestamps
    end
  end
end
