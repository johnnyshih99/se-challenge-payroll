require 'csv'
class Report < ActiveRecord::Base
  has_many :jobs
  
  def self.import(file)
    # assume there will always be a well-formed footer line
    # get report_id
    last_line_a = get_last_line(file).split(',')
    report_id = last_line_a.second.to_i

    r = Report.find_by_id report_id
    return "Import Failed - Report with report id #{report_id} already exists." if !r.nil?

    r = Report.new
    r.id = report_id
    r.save!
      
    CSV.foreach(file.path, headers:true) do |row|
      next if row["date"] == "report id"
      date = row["date"]
      hours_worked = row["hours worked"]
      employee_id = row["employee id"]
      job_group = row["job group"]

      e = Employee.find_by_id row["employee id"]
      if e.nil?
        e = Employee.new
        e.id = employee_id
        e.save!
      end

      job = Job.new
      job.report = r
      job.employee = e
      job.date = date
      job.hours_worked = hours_worked
      job.job_group = job_group
      job.save
    end

    return "Successfully Imported #{file.original_filename}"
  end

  private
  # extract last line (footer) of a file
  def self.get_last_line(file)
    f = File.open(file.path)
    f.seek(-2, IO::SEEK_END) #pos -1 is newline at end of file
    last_line = nil

    while f.pos > 0
      if f.getc == "\n"
        last_line = f.read
        break
      else
        f.pos -= 2  #getc advances position by 1
      end
    end

    last_line = f.read unless last_line

    f.close
    
    return last_line
  end
end
