# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SimpleProductManagerExtension < Radiant::Extension
  version "0.1"
  description "Manages Products and Product Categories for use across the site."
  url "http://github.com/jstirk/radiant-simple-product-manager/tree/master"
  
  define_routes do |map|
    #map.connect 'admin/products/:action', :controller => 'admin/simple_product_manager'
    map.with_options(:controller => 'admin/product') do |product|
    	product.product_index  'admin/product',            :action => 'index'
    	product.product_new    'admin/product/new',        :action => 'new'
    	product.product_edit   'admin/product/edit/:id',   :action => 'edit'
    	product.product_remove 'admin/product/remove/:id', :action => 'remove'
  	end
  	map.with_options(:controller => 'admin/course') do |course|
    	course.course_index  'admin/course',            :action => 'index'
    	course.course_new    'admin/course/new',        :action => 'new'
    	course.course_edit   'admin/course/edit/:id',   :action => 'edit'
    	course.course_remove 'admin/course/remove/:id', :action => 'remove'
  	end
    map.with_options(:controller => 'admin/category') do |category|
    	category.category_index  'admin/category',            :action => 'index'
    	category.category_new    'admin/category/new',        :action => 'new'
    	category.category_edit   'admin/category/edit/:id',   :action => 'edit'
    	category.category_remove 'admin/category/remove/:id', :action => 'remove'
  	end

  end
  
  def activate
    admin.tabs.add "Products", "/admin/product", :after => "Layouts", :visibility => [:all]
    Page.send :include, SimpleProductManagerTag
  end
  
  def deactivate
    admin.tabs.remove "Products"
  end
  
end
