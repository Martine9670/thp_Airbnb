class AddCityToListings < ActiveRecord::Migration[8.0]
  def change
    add_reference :listings, :city, null: false, foreign_key: true
  end
end
