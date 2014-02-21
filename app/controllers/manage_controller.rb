class ManageController < ApplicationController
  filter_access_to :all
  before_filter :authorize_manager, :except => [:sign_in,:login]

  FILE_MAXIMUM_SIZE=1508576
  FILE_EXTENSIONS = [".jpg",".jpeg",".png"]
  
  def sign_in

  end

  def login
    puts("tapinda mu login")
    expiry = Date.new(2014, 06, 30)
    today = DateTime.now
    diff = expiry - today
    @days_left = diff
    if diff > 0
          if request.post?
            user = User.authenticate_manager(params[:random_pass], params[:mobile_number])
          if user
          session[:user_id] = user.id
          redirect_to(:controller => 'manage' )
          else
          flash[:notice] = "Invalid access token entered."
          redirect_to(:controller => 'manage', :action => 'sign_in' )
          end
          end
    else
      flash.now[:notice] = "Your access token has expired for the day you need to sign up for a new token."
    end
  end

  def logout
    @user = current_user
      session[:user_id] = nil
      session.clear
      flash[:notice] = "Logged out"
      redirect_to({:controller=>'manage', :action => "sign_in"} )
  end
  
  def index
    @unpaid_orders = CustomerOrder.unpaid_orders
    @unprocessed_orders = CustomerOrder.unprocessed_orders
    @undelivered_orders = CustomerOrder.undelivered_orders
    @uncollected_orders = CustomerOrder.uncollected_orders
    @unpaid = @unpaid_orders.count
    @unprocessed = @unprocessed_orders.count
    @undelivered = @undelivered_orders.count
    @uncollected = @uncollected_orders.count
    
  end

  def slideshow
    puts("tapinda mu slideshow")
    @config = GlobalSetting.get_multiple_configs_as_hash ['Slide1Url', 'Slide2Url', 'Slide3Url', 'Slide4Url']
  end

  def update_settings
    puts("tapindaaaaaaaaaaaaaaaaaaaaaaaa")
    @config = GlobalSetting.get_multiple_configs_as_hash ['Slide1Url', 'Slide2Url', 'Slide3Url', 'Slide4Url']
    if request.post?
      Configuration.set_config_values(params[:configuration])
    end
  end

  def save_slideshow_image
    @temp_file=params[:upload][:datafile]
    puts("the size of the file is #{@temp_file.size}")
    if request.post?
      unless params[:upload].nil?
        unless FILE_EXTENSIONS.include?(File.extname(@temp_file.original_filename).downcase)
            flash[:notice] = 'Invalid Extention. Image must be .JPG or .PNG'
            redirect_to :action => 'index' and return
        end
        if @temp_file.size > FILE_MAXIMUM_SIZE
            flash[:notice] = 'File too large. File size should be less than 500 Kilobytes'
            redirect_to :action => 'index' and return
        end
      end
        GlobalSetting.save_slideshow_image(params[:upload]) unless params[:upload].nil?
        flash[:notice] = "Your image has been uploaded successfully"
        redirect_to :action => 'index' and return
    end
  end

  def update_slide_image
    puts("takuda ku updater image to slide")
    @index = params[:id]
    @path = "/#{params[:path]}"
    if @index == "0"
      keyset = "Slide1Url"
      elsif @index == "1"
      keyset = "Slide2Url"
      elsif @index == "2"
      keyset = "Slide3Url"
      elsif @index == "3"
      keyset = "Slide4Url"
    end
    @config = GlobalSetting.find_by_config_key(keyset)
    @config.update_attribute(:config_value, @path)
    flash[:notice] = " Slideshow Image has been successfully updated."
    redirect_to :action => 'index'
  end

  def delete_slide_image
    path_to_file = "public/#{params[:path]}"
    File.delete(path_to_file)
    flash[:notice]= "The file has been successfully deleted."
    redirect_to :action => 'index'
  end

  def unpaid_orders
    @unpaid_orders = CustomerOrder.unpaid_orders
    respond_to do |format|
      format.js if request.xhr?
      format.html
      end
  end

  def unprocessed_orders
    @unprocessed_orders = CustomerOrder.unprocessed_orders
    respond_to do |format|
      format.js if request.xhr?
      format.html
      end
  end

  def undelivered_orders
    @undelivered_orders = CustomerOrder.undelivered_orders
    respond_to do |format|
      format.js if request.xhr?
      format.html
      end
  end

  def uncollected_orders
    @uncollected_orders = CustomerOrder.uncollected_orders
    respond_to do |format|
      format.js if request.xhr?
      format.html
      end
  end

  def process_payment
    @order = Order.find(params[:id])
    respond_to do |format|
      format.js if request.xhr?
      format.html
      end
  end

  def update_payment
    @order = Order.find(params[:id])
    if params[:order][:trans_code].empty?
      flash[:notice] = "Error! The approval code box cannot be null."
      redirect_to :action => 'index'
    else
      respond_to do |format|
        if @order.update_attributes(params[:order])
          @order.update_attribute(:paid, true)
#          @order.update_attribute(:trans_code, params[:order][:trans_code])
          flash[:notice] = "Payment for order #{@order.order_number} has been successfully approved."
          format.html { redirect_to(:action => 'index') }
          format.xml  { head :ok }
        else
          format.html { render :action => "index" }
          format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def order_processing_by_admin
    @order = Order.find(params[:id])
    @order.update_attribute(:processed, true)
    flash[:notice] = 'Order Processing has been successful.'
    redirect_to :action => 'index'
  end

  def update_order
    @order = Order.find(params[:id])
    mark_as_paid
  end

#  Orders Reports

  def reports
      respond_to do |format|
      format.js if request.xhr?
      format.html
      end
  end

  def unpaid_orders_pdf
    @today = Date.today
    @unpaid_orders = Order.unpaid_orders
     respond_to do |format|
      format.pdf { render :layout => false }
    end
  end

  def unprocessed_orders_pdf
    @today = Date.today
    @unprocessed_orders = Order.unprocessed_orders
     respond_to do |format|
      format.pdf { render :layout => false }
    end
  end

  def pending_delivery_pdf
    @today = Date.today
    @pending_delivery = Order.undelivered_orders
     respond_to do |format|
      format.pdf { render :layout => false }
    end
  end

  def pending_collection_pdf
    @today = Date.today
    @pending_collection = Order.uncollected_orders
     respond_to do |format|
      format.pdf { render :layout => false }
    end
  end

  def stock_sheet_pdf
    @today = Date.today
    @products = Product.find_products
    respond_to do |format|
      format.pdf { render :layout => false }
    end
  end

  private

  def mark_as_paid
    @order.update_attribute(:paid, true)
  end
  
end
