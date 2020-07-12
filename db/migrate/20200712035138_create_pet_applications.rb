class CreatePetApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :pet_applications do |t|
      t.integer :pet_id
      t.integer :appplication_id

      t.timestamps
    end
  end
end
