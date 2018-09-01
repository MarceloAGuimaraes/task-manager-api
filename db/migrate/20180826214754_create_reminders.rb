class CreateReminders < ActiveRecord::Migration[5.0]
  def change
    create_table :reminders do |t|
      t.string :name
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
