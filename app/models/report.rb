require 'csv'
class Report < ActiveRecord::Base
  has_many :jobs
  
  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      # e = Employee.where(name: row["employee name"], address: row["employee address"]).take
      # if e.nil?
      #   e = Employee.new
      #   e.name = row["employee name"]
      #   e.address = row["employee address"]
      #   e.save!
      # end

      # u = Expense.new
      # u.employee = e
      # d = Date.strptime(row["date"], "%m/%d/%Y")
      # u.date = d
      # u.category = row["category"]
      # u.expense_desc = row["expense description"]
      # u.amount = row["pre-tax amount"]
      # u.tax_name = row["tax name"]
      # u.tax_amount = row["tax amount"]
      # u.save!
    end
  end
end
