class CreateTemperatures < ActiveRecord::Migration[5.2]
  def change
    create_table :temperatures do |t|
      t.float :temp

      t.timestamps
    end
  end
end
