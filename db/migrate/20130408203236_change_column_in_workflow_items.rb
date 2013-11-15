class ChangeColumnInWorkflowItems < ActiveRecord::Migration
  def up
    change_column :workflow_items, :formparams, :text, :limit => nil
  end

  def down
  end
end
