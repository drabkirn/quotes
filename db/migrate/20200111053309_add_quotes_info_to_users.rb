class AddQuotesInfoToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :quotes_token, :string, default: ""
    add_column :users, :quotes_api_count, :integer, default: 0
  end
end
