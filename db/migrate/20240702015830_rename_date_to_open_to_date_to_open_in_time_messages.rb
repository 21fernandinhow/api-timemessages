class RenameDateToOpenToDateToOpenInTimeMessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :time_messages, :dateToOpen, :date_to_open
  end
end