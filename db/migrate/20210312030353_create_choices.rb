class CreateChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :choices do |t|
      t.integer :topic_id

      t.timestamps
    end
  end
end
