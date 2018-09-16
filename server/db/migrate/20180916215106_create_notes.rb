class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :title,    nulL: false
      t.string :content,  null: false
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
