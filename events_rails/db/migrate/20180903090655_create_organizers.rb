class CreateOrganizers < ActiveRecord::Migration[5.2]
  def change
    create_table :organizers do |t|
      t.string :name
      t.string :tel
      t.string :fax
      t.string :contact_staff_name
      t.string :contact_staff_tel

      t.timestamps
    end
  end
end
