class CartItem
  attr_reader :product, :quantity

  def initialize(product)
    @product = product
    @quantity = 1
  end

  def increment_quantity
    @quantity += 1
  end

  def code
    @product.code
  end

  def name
    @product.name
  end
  
  def description
    @product.description
  end

  def price
    @product.price * @quantity
  end

  def delivery_price
    @product.delivery_price * @quantity
  end


end