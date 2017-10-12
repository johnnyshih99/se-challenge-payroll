class Job < ActiveRecord::Base
  belongs_to :employee
  belongs_to :report
end
