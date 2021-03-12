class AddMoreFieldsToChoices < ActiveRecord::Migration[6.0]
  def change
    add_column :choices, :description, :string
  end
end
