class Job < ActiveRecord::Base
  belongs_to :employee
  belongs_to :report

  # job group rate per hour
  # alternatively if the number of job group is to increase we can
  # create a model for it
  def self.job_group_rate
  	{
  		"A" => 20,
  		"B" => 30
  	}
  end
end
