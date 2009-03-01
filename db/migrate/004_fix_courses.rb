class FixCourses < ActiveRecord::Migration
  
  def self.up
     remove_column :products, :type
     remove_column :products, :capacity
     remove_column :products, :start_date
     
     create_table :courses do |t|
       t.string :title, :limit => 255
       t.text :description
       t.decimal :price, :precision => 10, :scale => 2
       t.string :photo, :limit => 255
       t.boolean :is_visible, :default => true
       t.integer :category_id, :null => false
       t.integer  :capacity, :null => false
       t.datetime :start_date
       t.timestamps
     end

     add_index :courses, :category_id
     add_index :courses, :title
     add_index :courses, :price
     
  end

   def self.down
    add_column :products, :type, :string
    add_column :products, :capacity, :integer
    add_column :products, :start_date, :datetime
  end

end
