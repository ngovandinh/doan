class Admin::QuessionsController < ApplicationController
  layout "admin"
  def index
    @quessions= Quession.paginate(page: params[:page])
  end

  def new
    @quession = Quession.new
    2.times { @quession.answers.build }
  end

  def create
    @quession = Quession.new(quession_params)
    if @quession.save
      flash[:success] = "quession created!"
      redirect_to action: :index
    else
      flash[:danger] = "quession is unvalid!"
      render action: :new
    end
  end

  def edit
    @lessions = Lession.all
    @quession = Quession.find_by(id: params[:id])
  end

  def update
    @quession = Quession.find_by(id: params[:id])
    if @quession.update_attributes(quession_params)
      flash[:success] = "update quession success!!!"
      redirect_to action: :index
    else
      render :edit
    end
  end

  def import_csv
     Question.import params[:file]
     redirect_to root_url, notice: "Question imported"
  end


  def destroy
    @quession = Quession.find_by(id: params[:id])
    byebug
    @quession.destroy
    flash[:success]=  "delete quession success!!!"
    redirect_to request.referrer || root_url
  end

  private
  def quession_params
    params.require(:quession).permit!
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.is_admin?
  end
end
