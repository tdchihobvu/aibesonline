class ProductsController < ApplicationController
  filter_access_to :all
  before_filter :authorize_manager
  # GET /products
  # GET /products.json
  FILE_MAXIMUM_SIZE=1508576
  FILE_EXTENSIONS = [".jpg",".jpeg",".png"]

  def index
    @products = Product.all(:limit => 20, :order => 'name ASC')
    @all = Product.all
    @cat_name = "All"
    @count = @all.count
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def products_by_category
    @categories = ProductCategory.find(:all)
  end

  def category_products
    @category = ProductCategory.find(params[:id])
    @products = Product.find_all_by_product_category_id(@category.id, :order => 'name ASC')
    @cat_name = @category.name
    @count = @products.count
  end

  def search_ajax
    @products = Product.find(:all,
      :conditions => "(name LIKE \"#{params[:query]}%\"
      OR description LIKE \"#{params[:query]}%\"
      OR code LIKE \"#{params[:query]}%\")",
      :order => "name asc") unless params[:query] == ''
      params[:id].nil?
      unless @products.nil?
      @search_count = @products.count
      end
    render :layout => false
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        prefix = @product.name.first.upcase
        @product.update_attribute(:name_prefix, prefix)
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])
    @product.name_prefix = @product.name.first.upcase
    respond_to do |format|
      if @product.update_attributes(params[:product])

        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload_image
    @product = Product.find(params[:id])
    puts("tiritiiiiiiiiiiiiiii iwe")
  end

  def save_uploaded_image
    @product = Product.find(params[:id])
    product = @product.id
    @temp_file=params[:upload][:datafile]
    puts("the size of the file is #{@temp_file.size}")
    if request.post?
      unless params[:upload].nil?
        unless FILE_EXTENSIONS.include?(File.extname(@temp_file.original_filename).downcase)
            flash[:notice] = 'Invalid Extention. Image must be .JPG or .PNG'
            redirect_to :action => 'show', :id => @product.id and return
        end
        if @temp_file.size > FILE_MAXIMUM_SIZE
            flash[:notice] = 'File too large. File size should be less than 500 Kilobytes'
            redirect_to :action => 'show', :id => @product.id and return
        end
      end
        Product.save_product_image(params[:upload], product) unless params[:upload].nil?
        flash[:notice] = "Your image has been uploaded successfully"
        redirect_to :action => 'show',:id => @product.id  and return
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
