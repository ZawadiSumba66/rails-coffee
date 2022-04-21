# frozen_string_literal: true

class AddNameColumnToCoffee < ActiveRecord::Migration[7.0]
  def change
    add_column :coffees, :name, :string
  end
end
