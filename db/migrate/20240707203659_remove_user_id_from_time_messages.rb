class RemoveUserIdFromTimeMessages < ActiveRecord::Migration[6.0]
  def change
    remove_column :time_messages, :user_id, :integer
  end
end

