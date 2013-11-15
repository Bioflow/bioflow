class AddCommandlineToWorkflowItems < ActiveRecord::Migration
  def change
      add_column :workflow_items, :commandline, :string
  end
end
