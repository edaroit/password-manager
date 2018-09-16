class CreateLogins < ActiveRecord::Migration[5.2]
  def change
    create_table :logins do |t|
      t.string :username, nulL: false
      t.string :password, null: false
      t.string :site,     null: false
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
