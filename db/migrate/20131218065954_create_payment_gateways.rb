class CreatePaymentGateways < ActiveRecord::Migration
  def change
    create_table :payment_gateways do |t|
      t.string :name
      t.string :provider

      t.timestamps
    end
  end
end
