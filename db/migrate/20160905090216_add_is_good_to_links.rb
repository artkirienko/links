class AddIsGoodToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :is_good, :boolean, default: true
  end
end
