class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name,              null: false
      t.text :description,         null: false
      t.integer :price,            null: false
      t.references :user,          null: false, foreign_key: true
      t.integer :category_id,      null: false                    # ActiveHash
      t.integer :condition_id,     null: false                    # ActiveHash
      t.integer :handling_time_id, null: false                    # ActiveHash
      t.integer :postage_payer_id, null: false                    # ActiveHash
      t.integer :prefecture_id,    null: false                    # ActiveHash
      t.timestamps
    end
  end
end