class AddOutputsToWorkflowItems < ActiveRecord::Migration
  def change
    add_column :workflow_items, :outputs, :string
  end
end
