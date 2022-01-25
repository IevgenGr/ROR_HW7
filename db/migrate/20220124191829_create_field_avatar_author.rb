class CreateFieldAvatarAuthor < ActiveRecord::Migration[6.1]
  def change
    add_column :authors, :avatar_url, :string
  end
end
