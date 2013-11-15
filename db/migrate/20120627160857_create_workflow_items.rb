class CreateWorkflowItems < ActiveRecord::Migration
  def change
    create_table :workflow_items do |t|
      t.string :name
      t.string :summary
      t.integer :totalinputs
      t.integer :totaloutputs
      t.string :category
      t.boolean :isparent
      t.string :parent
      t.string :itemid

      t.timestamps
    end
  end
end
