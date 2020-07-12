class RemovePetIdsFromApplications < ActiveRecord::Migration[5.1]
  def change
    remove_column :applications, :pet_ids, :integer
  end
end
