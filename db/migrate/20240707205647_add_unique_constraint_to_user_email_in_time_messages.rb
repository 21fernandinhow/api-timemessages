class AddUniqueConstraintToUserEmailInTimeMessages < ActiveRecord::Migration[7.1]
  def change
    add_index :time_messages, :user_email, unique: true, null: false
  end
end

