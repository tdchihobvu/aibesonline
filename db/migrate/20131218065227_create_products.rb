class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :code, :null => false
      t.string  :name, :null => false
      t.string  :release_year
      t.string  :name_prefix

      t.decimal :price, :null => false, :precision => 8, :scale => 2, :default => 0.00
      t.decimal :unit_vat, :precision => 8, :scale => 2, :default => 0.00

      t.text    :description

      t.integer :quantity, :null => false
      t.integer :product_type_id, :null => false, :options => "CONSTRAINT fk_product_proct_types REFERENCES product_types(id)"
      t.integer :product_category_id, :null => false, :options => "CONSTRAINT fk_product_product_categories REFERENCES product_categories(id)"
      t.integer :product_brand_id, :null => false, :options => "CONSTRAINT fk_product_product_brands REFERENCES product_brands(id)"
      t.integer :sales
      t.integer :views
      t.integer :promotion_days
      
      t.boolean :on_promotion, :default => false
      t.boolean :featured, :default => false
      t.boolean :top_10, :default => false

      t.timestamps
    end
  end
end
