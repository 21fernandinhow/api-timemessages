class CreateTimeMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :time_messages do |t|
      t.string :content
      t.datetime :dateToOpen
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
