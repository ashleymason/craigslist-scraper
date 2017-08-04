class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title, null: false
      t.string :price, null: false
      t.string :post_date, null: false
    end
  end
end
