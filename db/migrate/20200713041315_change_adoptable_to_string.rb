class ChangeAdoptableToString < ActiveRecord::Migration[5.1]
  def up
    change_column :pets, :adoptable, :string, :default => "adoptable"
  end

  def down
    change_column :pets, :adoptable, :boolean
  end
end
