class ReportsController < ApplicationController
  def index
    @data = []
    emps = Employee.all

    emps.each do |e|
      # deep_sort_by_keys works but at the end sorting is separated out to 
      # allow flexibility when sorting different layers (years, months, halves)
      # h = deep_sort_by_keys(e.amount_per_pay_period)
      h = e.amount_per_pay_period
      
      h = h.sort_by {|k,v| k} #sort years
      h.each do |year, year_v|
        year_v = year_v.sort_by {|k,v| k} #sort months
        year_v.each do |month, month_v|
          month_v = month_v.sort_by {|k,v| k} #sort halves
          month_v.each do |half, half_v|
            @data << {
              id: e.id,
              pay_period: half_v.last,
              amount_paid: half_v.first
            }
          end
        end
      end
    end
  end

  def import
    begin
      msg = Report.import(params[:file])
    rescue => e
      msg = "Import failed. Error: " + e.message
    end
        
    redirect_to root_url, notice: msg
  end

  private
  def deep_sort_by_keys(h) #sort nested hash by keys
    h.each do |k, v|
      if v.class == Hash
        deep_sort_by_keys(v) 
        h[k] = v.sort_by {|hk, hv| hk}
      end
    end
    h = h.sort_by {|k,v| k}
  end
end
