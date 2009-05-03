class Order  < ActiveRecord::Base

  def self.paypal_url(product, return_url)
    values = {
      :business => 'foo_123_biz@example..com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => product.id
    }
    values.merge!({
      "amount_1" => product.price,
      "item_name_1" => product.title,
      "item_number_1" => product.id
    })

    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end 
end
