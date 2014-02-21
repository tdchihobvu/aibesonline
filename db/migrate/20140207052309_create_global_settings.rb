class CreateGlobalSettings < ActiveRecord::Migration
  def change
    create_table :global_settings do |t|
      t.string :config_key
      t.string :config_value

    end
  end
end
