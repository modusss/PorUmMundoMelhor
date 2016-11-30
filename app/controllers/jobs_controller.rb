class JobsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_job, only: [:edit, :update, :show]
  def index
    @jobs = Job.all
    if params[:search]
      #we are going to search by job title
      search_title = params[:search][:title]
      search_category = params[:search][:category]
      @jobs = Job.search(search_title,search_category).order(created_at: :desc)
    end
  end

  def show
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user_id = current_user.id
    if @job.save
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to job_path(@job)
    else
      render :edit
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :short_description,
                                :category, :title, :remote, :finish, :address, :date, picture: [])
  end
end
