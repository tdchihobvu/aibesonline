class Cart
    attr_reader :items

    # Initialize items array
    def initialize
      @items = []
    end
    # Add product to the items array
    def add_product(product)
    current_item = @items.find {|item| item.product == product}
    if current_item
    current_item.increment_quantity
    else
    current_item = CartItem.new(product)
    @items << current_item
    end
    current_item
    end

    def total_price
      @items.sum { |item| item.price }
    end

    def total_delivery_price
      @items.sum { |item| item.delivery_price }
    end

    def total_items
    @items.sum { |item| item.quantity }
    end
end