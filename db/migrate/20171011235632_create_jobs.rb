class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.date :date
      t.decimal :hours_worked
      t.string :job_group
      t.references :employee, index: true, foreign_key: true
      t.references :report, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
