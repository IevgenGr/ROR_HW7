class AddCountViewToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :count_view, :integer, default: 0
  end
end
