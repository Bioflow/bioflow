class AddFormparamsToWorkflowItems < ActiveRecord::Migration
  def change
    add_column :workflow_items, :formparams, :string
  end
end
