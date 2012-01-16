class CreateParams < ActiveRecord::Migration
  def change
    create_table :params do |t|
      t.string :name
      t.references :Function
      t.timestamps
    end
  end
end
