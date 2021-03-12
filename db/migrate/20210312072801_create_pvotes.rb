class CreatePvotes < ActiveRecord::Migration[6.0]
  def change
    create_table :pvotes do |t|
      t.integer :post_id

      t.timestamps
    end
  end
end
