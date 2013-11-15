class AddInputsToWorkflowItems < ActiveRecord::Migration
  def change
    add_column :workflow_items, :inputs, :string
  end
end
