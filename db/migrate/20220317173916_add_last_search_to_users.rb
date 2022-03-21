class AddLastSearchToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_search, :string
  end
end
