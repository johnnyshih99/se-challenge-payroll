class ReportsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def import
    Report.import(params[:file])
    redirect_to root_url, notice: "Imported #{params[:file].original_filename}"
  end
end
