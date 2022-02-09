class AlterBookingsModifyRazorpay < ActiveRecord::Migration[7.0]
  def change
    rename_column :bookings, :rayzorpay_checkout_id, :razorpay_checkout_id
    add_column :bookings, :expires_at, :datetime
  end
end
