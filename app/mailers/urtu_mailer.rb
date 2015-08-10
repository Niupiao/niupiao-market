class UrtuMailer < ApplicationMailer
  def send_driver_invoice(driver, amount)
    @amount = amount
    @mail = mail.to(to: driver.email, subject: "#{Date.today.strfttime("%B")}'s Invoice for #{driver.name}", body: "#{amount}")
   # @mail.delivery_method :sendmail
    #@mail.deliver
  end
end
