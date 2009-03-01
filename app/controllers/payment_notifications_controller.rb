require 'app/models/payment_notification'
class PaymentNotificationsController < ActionController::Base
  protect_from_forgery :except => [:create]
  
  def create
    ::PaymentNotification.create!(:params => params, :status => params[:payment_status], :transaction_id => params[:txn_id])

     url = 'http://www.sandbox.paypal.com/cgi-bin/webscr'
     values = {
        :cmd => '_notify_sync',
        :tx => params[:txn_id],
        :at => 'foo_1235882517_biz@gmail.com'
      }
      
    Net::HTTP.post_form(URI.parse(url),values.to_query)
    render :nothing => true
  end
end