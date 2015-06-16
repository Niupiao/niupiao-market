module UsersHelper
  #  Creates a receipt for the User for the given item.
  def get_receipt(user, item, quantity_purchased, total_charge)
      if user
          user.receipts.create(
                               item_name: item.name, 
                               item_quantity: quantity_purchased,
                               item_tags: item.tags,
                               item_type: item.item_type,
                               seller_name: item.user.first_name + " " + item.user.last_name,
                               seller_id: item.user.id,
                               charge: total_charge
                               )
      else
        flash[:danger] = "You must be logged in to get a receipt"
        redirect_to login_path
      end
  end
end
