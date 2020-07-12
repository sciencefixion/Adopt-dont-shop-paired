class DropPetApplicationsTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :pet_applications
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
