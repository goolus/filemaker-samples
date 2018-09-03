class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :body
      t.datetime :pub_date
      t.string :organizer
      t.text :image

      t.timestamps
    end
  end
end
