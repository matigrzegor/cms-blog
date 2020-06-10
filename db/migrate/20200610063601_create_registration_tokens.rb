class CreateRegistrationTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :registration_tokens do |t|
      t.string :token, null: false
      t.integer :expires_in, null: false

      t.timestamps
    end
  end
end
