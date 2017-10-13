class Employee < ActiveRecord::Base
  has_many :jobs

  # returns a nested hash structure
  def amount_per_pay_period
    data = {}
    rate = Job.job_group_rate
    jobs = self.jobs

    jobs.each do |job|
      amount_paid = job.hours_worked * rate[job.job_group]

      mid = job.date.beginning_of_month + 15.days
      if job.date < mid
        half = 1
        date_str = job.date.beginning_of_month.strftime("%d/%m/%Y") + " - " + (mid - 1.day).strftime("%d/%m/%Y")
      else
        half = 2
        date_str = mid.strftime("%d/%m/%Y") + " - " + job.date.end_of_month.strftime("%d/%m/%Y")
      end

      if data[job.date.year].nil?
        data[job.date.year] = {
          job.date.month => {
            half => [amount_paid, date_str]
          }
        }
      elsif data[job.date.year][job.date.month].nil?
        data[job.date.year][job.date.month] = {
          half => [amount_paid, date_str]
        }
      elsif data[job.date.year][job.date.month][half].nil?
        data[job.date.year][job.date.month][half] = [amount_paid, date_str]
      else
        data[job.date.year][job.date.month][half][0] += amount_paid
      end
    end

    return data
  end
end
