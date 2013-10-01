class RenameActiveCodeToTokenizedCode < ActiveRecord::Migration
  def change
    rename_column :users, :active_code, :tokenized_code
  end
end
