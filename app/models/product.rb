class Product < ActiveRecord::Base
	belongs_to :category
	def paypal_url(return_url)
    values = {
      :business => 'seller_1229899173_biz@railscasts.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id
    }
    values.merge!({
      "amount_#{index+1}" => self.price,
      "item_name_#{index+1}" => self.title,
      "item_number_#{index+1}" => self.id
    })
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
