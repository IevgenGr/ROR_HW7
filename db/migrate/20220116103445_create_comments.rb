class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.belongs_to :post
      t.belongs_to :author
      t.text :body
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
