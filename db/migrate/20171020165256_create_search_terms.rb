class CreateSearchTerms < ActiveRecord::Migration
  def change
    create_table :search_terms do |t|
      t.string :search

      t.timestamps null: false
    end
  end
end
