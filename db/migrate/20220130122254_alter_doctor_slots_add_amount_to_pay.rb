class AlterDoctorSlotsAddAmountToPay < ActiveRecord::Migration[7.0]
  def change
    add_column :doctor_slots,
      :amount_to_pay,
      :integer,
      null: false,
      default: 0
  end
end
