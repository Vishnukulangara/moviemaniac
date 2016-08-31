class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :movie
      t.text :description
      t.string :director
      t.string :cast
      t.integer :year
      t.string :duration

      t.timestamps null: false
    end
  end
end
