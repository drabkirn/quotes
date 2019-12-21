class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.string :title, default: ""
      t.text :content
      t.string :author, default: ""
      t.text :tags, array: true

      t.timestamps
    end
  end
end
