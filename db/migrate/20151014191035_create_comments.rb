class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :text
      t.references :article, index: true, foreign_key: true

      t.timestamps
    end
  end
end
