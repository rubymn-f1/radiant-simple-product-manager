module SimpleProductManagerTag
  include Radiant::Taggable
  include ERB::Util
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::UrlHelper

  tag 'products' do |tag|
    tag.expand
  end
  
  tag 'product' do |tag|
  	tag.expand
  end

	desc "Find a specific product using the SQL conditions specified by 'where'"  
  tag 'product:find' do |tag|
    attr = tag.attr.symbolize_keys
    where=attr[:where]
    product=Product.find(:first, :conditions => where)
    if product then
    	tag.locals.product = product
    end
    tag.expand
  end

	desc "Iterate over all products in the system, optionally sorted by the field specified by 'order', or constrained by 'where'."
  tag 'products:each' do |tag|
    attr = tag.attr.symbolize_keys
    order=attr[:order] || 'title ASC'
    where=attr[:where]
    result = []
    if tag.locals.category then
    	prods=tag.locals.category.products.find(:all, :conditions => where, :order => order)
    else
	    prods=Product.find(:all, :conditions => where, :order => order)
	  end
    prods.each do |product|
      tag.locals.product = product
      result << tag.expand
    end
    result
  end

	desc "Renders the ID of the current product loaded by <r:product> or <r:products:each>"
  tag 'product:id' do |tag|
    product = tag.locals.product
    html_escape product.id
  end
  
 	desc "Renders the HTML-escaped title of the current product loaded by <r:product> or <r:products:each>"
  tag 'product:title' do |tag|
    product = tag.locals.product
    html_escape product.title
  end
  
 	desc "Renders the HTML-escaped description of the current product loaded by <r:product> or <r:products:each>"
  tag 'product:description' do |tag|
    product = tag.locals.product
    html_escape product.description
  end
  
 	desc "Renders the price of the current product loaded by <r:product> or <r:products:each>. Formatting can be specified by 'precision', 'unit', 'separator' and 'delimiter'"
  tag 'product:price' do |tag|
	  attr = tag.attr.symbolize_keys
    product = tag.locals.product
    precision=attr[:precision]
    if precision.nil? then
    	precision=2
    else
    	precision=precision.to_i
    end
    number_to_currency(product.price.to_f, 
                       :precision => precision,
                       :unit => attr[:unit] || "$",
                       :separator => attr[:separator] || ".",
                       :delimiter => attr[:delimiter] || ",")
  end
  
  desc "Renders an <img> element for the current product loaded by <r:product> or <r:products:each>.. Optionally takes 'width' and 'height'."
  tag 'product:image' do |tag|
	  attr = tag.attr.symbolize_keys
    product = tag.locals.product
    image_tag product.photo, :alt => product.title, :size => "#{attr[:width]}x#{attr[:height]}"
  end
  
  desc "Renders the photo URL of the current product loaded by <r:product> or <r:products:each>."
  tag 'product:photo_url' do |tag|
  	product = tag.locals.product
  	product.photo
  end
  
  tag 'categories' do |tag|
    tag.expand
  end
  
  tag 'category' do |tag|
    tag.expand
  end
  
	desc "Find a specific category using the SQL conditions specified by 'where'"  
  tag 'category:find' do |tag|
		attr = tag.attr.symbolize_keys
    where=attr[:where]
    category=Category.find(:first, :conditions => where)
    if category then
    	tag.locals.category = category
    end
    tag.expand
  end

	desc "Iterate over all categories in the system, optionally sorted by the field specified by 'order', or constrained by 'where'."
  tag 'categories:each' do |tag|
    attr = tag.attr.symbolize_keys
    order=attr[:order] || 'title ASC'
    where=attr[:where]
    result = []
    Category.find(:all, :conditions => where, :order => order).each do |category|
      tag.locals.category = category
      result << tag.expand
    end
    result
  end

	desc "Renders the ID of the current category loaded by <r:category> or <r:categories:each>"
  tag 'category:id' do |tag|
    category = tag.locals.category
    html_escape category.id
  end
  
	desc "Renders the HTML-escaped title of the current category loaded by <r:category> or <r:categories:each>"
  tag 'category:title' do |tag|
    category = tag.locals.category
    html_escape category.title
  end
  
 	desc "Renders the HTML-escaped description of the current category loaded by <r:category> or <r:categories:each>"
  tag 'category:description' do |tag|
    category = tag.locals.category
    html_escape category.description
  end
  
  tag 'courses' do |tag|
    tag.expand
  end
  
  tag 'course' do |tag|
       tag.expand
  end
  
  desc "Find a specific course using the SQL conditions specified by 'where'"  
  tag 'course:find' do |tag|
    attr = tag.attr.symbolize_keys
    where=attr[:where]
    product=Course.find(:first, :conditions => where)
    if course then
       tag.locals.course = course
    end
    tag.expand
  end
  
  desc "Iterate over all courses in the system, optionally sorted by the field specified by 'order', or constrained by 'where'."
  tag 'courses:each' do |tag|
    attr = tag.attr.symbolize_keys
    order=attr[:order] || 'title ASC'
    where=attr[:where]
    result = []
    if tag.locals.category then
       courses=tag.locals.category.courses.find(:all, :conditions => where, :order => order)
    else
           courses=Course.find(:all, :conditions => where, :order => order)
         end
    courses.each do |c|
      tag.locals.course = c
      result << tag.expand
    end
    result
  end
  
  desc "Renders the ID of the current course loaded by <r:course> or <r:courses:each>"
  tag 'course:id' do |tag|
    course = tag.locals.course
    html_escape course.id
  end
  
 	desc "Renders the HTML-escaped title of the current course loaded by <r:course> or <r:courses:each>"
  tag 'course:title' do |tag|
    course = tag.locals.course
    html_escape course.title
  end
  
 	desc "Renders the HTML-escaped description of the current course loaded by <r:course> or <r:courses:each>"
  tag 'course:description' do |tag|
    course = tag.locals.course
    html_escape course.description
  end
  
 	desc "Renders the HTML-escaped capacity of the current course loaded by <r:course> or <r:courses:each>"
  tag 'course:capacity' do |tag|
    course = tag.locals.course
    html_escape course.capacity
  end
  
 	desc "Renders the HTML-escaped start_date of the current course loaded by <r:course> or <r:courses:each>"
  tag 'course:start_date' do |tag|
    course = tag.locals.course
    html_escape course.start_date
  end
  
 	desc "Renders the price of the current course loaded by <r:course> or <r:courses:each>. Formatting can be specified by 'precision', 'unit', 'separator' and 'delimiter'"
  tag 'course:price' do |tag|
	  attr = tag.attr.symbolize_keys
    course = tag.locals.course
    precision=attr[:precision]
    if precision.nil? then
    	precision=2
    else
    	precision=precision.to_i
    end
    number_to_currency(course.price.to_f, 
                       :precision => precision,
                       :unit => attr[:unit] || "$",
                       :separator => attr[:separator] || ".",
                       :delimiter => attr[:delimiter] || ",")
  end
  
  desc "Renders an <img> element for the current course loaded by <r:course> or <r:courses:each>.. Optionally takes 'width' and 'height'."
  tag 'course:image' do |tag|
	  attr = tag.attr.symbolize_keys
    course = tag.locals.course
    image_tag course.photo, :alt => course.title, :size => "#{attr[:width]}x#{attr[:height]}"
  end
  
  desc "Renders the photo URL of the current course loaded by <r:course> or <r:courses:each>."
  tag 'course:photo_url' do |tag|
  	course = tag.locals.course
  	course.photo
  end
  
  desc "Renders a paypal URL for a product and takes a callback URL"
  tag 'product:paypal_url' do |tag|
    attr = tag.attr.symbolize_keys
    product = tag.locals.product
    url=attr[:callback_url]
    link_to 'Buy this with PayPal', product.paypal_url(url)
  end
end
