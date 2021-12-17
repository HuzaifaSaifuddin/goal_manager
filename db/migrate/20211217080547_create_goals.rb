class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.string :description
      t.decimal :amount, precision: 15, scale: 2
      t.date :target_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
