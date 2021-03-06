module ReceiptsHelper
  
  #  Creates a receipt for the User for the given item.
  def get_receipt(buyer, seller, item, quantity_purchased, total_charge)
    checkin_code = SecureRandom.urlsafe_base64 11
    seller.receipts_sell.create(
                        item_id: item.id,
                        item_name: item.name,
                        item_quantity: quantity_purchased,
                        item_tags: item.tags,
                        item_type: item.item_type,
                        charge: total_charge,
                        status: "Unclaimed",
                        checkin_code: checkin_code,
                        buyer: buyer,
                        claimed: 0
                        )
    flash.now[:success] = "In order to keep track of your purchase, input this into the Tracker " + checkin_code
  end
end
