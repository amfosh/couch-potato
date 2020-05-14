class CreateShows < ActiveRecord::Migration[4.2]
  def change
    create_table :shows do |t|
      t.string  :show_title
      t.integer :user_id
    end
  end
end