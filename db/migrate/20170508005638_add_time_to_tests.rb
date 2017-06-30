class AddTimeToTests < ActiveRecord::Migration
  def change
    add_column :tests, :started_at, :datetime
    add_column :tests, :finnished_at, :datetime
    add_column :tests, :status, :string, default: :none
  end
end
