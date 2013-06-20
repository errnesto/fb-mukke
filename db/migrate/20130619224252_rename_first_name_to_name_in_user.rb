class RenameFirstNameToNameInUser < ActiveRecord::Migration
  def up
  	change_table :users do |t|
  		t.rename :first_name, :name
	end
  end
    def down
  	change_table :users do |t|
  		t.rename :name, :first_name
	end
  end
end
