class AddPriceColumnToCoffeePosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :price, :integer
  end
end
