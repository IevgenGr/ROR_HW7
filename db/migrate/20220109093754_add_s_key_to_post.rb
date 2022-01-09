class AddSKeyToPost < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :author
  end
end
