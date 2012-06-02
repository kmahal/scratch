class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :user_id
      t.integer :gradelevel
      t.string :Math
      t.string :Science
      t.string :English
      t.string :History
      t.boolean :private
      t.string :slug

      t.timestamps
    end
    add_index :grades, :slug, unique: true
  end
end
