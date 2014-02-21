require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { code: @product.code, description: @product.description, featured: @product.featured, name: @product.name, name_prefix: @product.name_prefix, on_promotion: @product.on_promotion, price: @product.price, product_brand_id: @product.product_brand_id, product_category_id: @product.product_category_id, product_type_id: @product.product_type_id, promotion_days: @product.promotion_days, quantity: @product.quantity, release_year: @product.release_year, sales: @product.sales, top_10: @product.top_10, unit_vat: @product.unit_vat, views: @product.views }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    put :update, id: @product, product: { code: @product.code, description: @product.description, featured: @product.featured, name: @product.name, name_prefix: @product.name_prefix, on_promotion: @product.on_promotion, price: @product.price, product_brand_id: @product.product_brand_id, product_category_id: @product.product_category_id, product_type_id: @product.product_type_id, promotion_days: @product.promotion_days, quantity: @product.quantity, release_year: @product.release_year, sales: @product.sales, top_10: @product.top_10, unit_vat: @product.unit_vat, views: @product.views }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
