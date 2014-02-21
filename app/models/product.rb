class Product < ActiveRecord::Base
  attr_accessible :code, :description, :featured, :name, :name_prefix, :on_promotion, :price, :product_brand_id, :product_category_id, :product_type_id, 
    :promotion_days, :quantity, :release_year, :top_10, :unit_vat, :delivery_price, :special_available, :upcoming

  # Building relationships between models
  belongs_to :product_type
  belongs_to :product_category
  belongs_to :product_brand
  has_many :customer_orders, :through => :line_items
  has_many :line_items, :dependent => :destroy

  # Validations
  validates :code, :presence => true, :uniqueness => true
  validates :name, :presence => true, :uniqueness => true

  PRODUCTS_ALPHABET = [
  # Displayed stored in db
  ["ALL" , "all" ],
  ["A - C" , "a-c" ],
  ["D - F" , "d-f" ],
  ["G - I" , "g-i" ],
  ["J - L" , "j-l" ],
  ["M - N" , "m-n" ],
  ["O - Q" , "o-q" ],
  ["R - T" , "r-t" ],
  ["U - W" , "u-w" ],
  ["X - Z" , "x-z" ]
  ]
 
  def self.products_for_sale
    find(
      :all,
      :order => 'name',
      :conditions => 'quantity >= 2 AND featured = 0 AND top_10 = 0',
      :limit => 10
    )
  end

  def self.top_ten_products
    find_all_by_top_10(
      true,
      :conditions => 'quantity >= 2',
      :order => 'name', :limit => 10
    )
  end

  def self.featured_products
    find_all_by_featured(
      true,
      :conditions => 'quantity >= 2',
      :order => 'name', :limit => 10
    )
  end

  def self.all_featured_products
    find_all_by_featured(
      true,
      :conditions => 'quantity >= 2',
      :order => 'name', :limit => 20
    )
  end

  def self.products_on_promotion
    find_all_by_on_promotion(
      true,
      :conditions => 'quantity >= 2',
      :order => 'name', :limit => 10
    )
  end

  def self.upcoming_movies
    find_all_by_upcoming(
      true,
      :order => 'name', :limit => 3
    )
  end

  def self.products_by_category(category)
    find_all_by_product_category_id(
      category,
      :conditions => 'quantity >= 2',
      :order => 'name'
    )
  end

  def self.products_on_promotion
  end

  def product_sales
    @orders = self.orders
    @orders.count
  end

  def number_of_sales
    @items = self.line_items
    sales = 0
    for i in @items
      sales += i.quantity
    end
    sales
  end

  def self.save_product_image(upload, product)
    @product = Product.find(product)
    name =  "#{@product.code}"".png"
    directory = "public/uploads"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
    image_path = "/uploads/#{name}"
    @product.update_attribute(:image_url, image_path)
  end

  # Protected or private methods
  protected
    def price_must_be_at_least_a_cent
    errors.add(:price, 'should be at least 0.01' ) if price.nil? || price < 0.01
    end

end
