class CreateTimeMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :time_messages do |t|
      t.string :content
      t.datetime :date_to_open
      t.string :user_email, null: false, unique: true

      t.timestamps
    end
  end
end