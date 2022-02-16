class CreateCoffee < ActiveRecord::Migration[7.0]
  def change
    create_table :coffees do |t|
      t.string :size
      t.string :milk
      t.string :topping
      t.numeric :quantity
      t.numeric :price
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
