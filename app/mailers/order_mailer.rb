class OrderMailer < ActionMailer::Base
  default from: "norepy@showtime.co.zw"

  def order_email(order,sent_at = Time.now)
    @order = CustomerOrder.find(order)
    @subject = "Showtime OnlineStore Order No. #{@order.order_no}"
    mail(to: "sales@showtime.co.zw", subject: @subject)

#    content_type "text/html"
  end
end
