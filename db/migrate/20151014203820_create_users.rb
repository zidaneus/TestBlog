class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fio
      t.date :dateBirth
      t.string :sex
      t.string :email

      t.timestamps
    end
  end
end
