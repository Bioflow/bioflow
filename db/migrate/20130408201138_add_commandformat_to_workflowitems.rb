class AddCommandformatToWorkflowitems < ActiveRecord::Migration
  def change
    add_column :workflow_items, :command_format, :string
  end
end
