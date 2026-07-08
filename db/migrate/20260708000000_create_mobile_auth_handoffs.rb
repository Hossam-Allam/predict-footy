class CreateMobileAuthHandoffs < ActiveRecord::Migration[8.0]
  def change
    create_table :mobile_auth_handoffs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token_digest, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end

    add_index :mobile_auth_handoffs, :token_digest, unique: true
    add_index :mobile_auth_handoffs, :expires_at
  end
end
