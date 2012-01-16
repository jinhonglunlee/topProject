class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.string :name
      t.references :Category
      
      t.timestamps
    end
  end
end
