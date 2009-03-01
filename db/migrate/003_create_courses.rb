class CreateCourses < ActiveRecord::Migration
  def self.up
      add_column :products, :type, :string
      add_column :products, :capacity, :integer
      add_column :products, :start_date, :datetime
  end
  
  def self.down
      remove_column :products, :type
      remove_column :products, :capacity
      remove_column :products, :start_date
  end
  
end
