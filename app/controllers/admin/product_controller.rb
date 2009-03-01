class Admin::ProductController < Admin::ResourceController
	model_class Product
	
	def new
    if request.post?
      @product = Product.new(params[:product])
      if @product.save()        
        flash[:notice] = "Success in creating the product"
        redirect_to :controller => 'admin/product', :action => 'index'
      else
        flash[:notice] = "Error creating the product"
      end
    end
  end
  
  def remove
    if request.post?
      @product = Product.find(params[:id])
      @product.destroy()
      flash[:notice] = "Product removed."
      redirect_to :controller => 'admin/product', :action => 'index'
    end
  end
  
  def edit
    if request.post?
      @product = Product.find(params[:id])
      if @product.update_attributes(params[:product])
        flash[:notice] = "Product updated"
        redirect_to :controller => 'admin/product', :action => 'index'
      else
        flash[:notice] = "Error updating product"
      end
    end
  end
end
