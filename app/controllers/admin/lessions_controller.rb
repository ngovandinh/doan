class Admin::LessionsController < ApplicationController
  layout "admin"
  def index
    @lessions= Lession.paginate(page: params[:page])
  end

  def new
    @categories = Category.all
    @lession = Lession.new
  end

  def create
    @lession = Lession.new(lession_params)
    if @lession.save
      flash[:success] = "lession created!"
      redirect_to action: :index
    else
      flash[:danger] = "lession is unvalid!"
      render action: :new
    end
  end

  def edit
    @categories = Category.all
    @lession = Lession.find_by(id: params[:id])
  end

  def update
    @lession = Lession.find_by(id: params[:id])
    if @lession.update_attributes(lession_params)
      flash[:success] = "update lession success!!!"
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    @lession = Lession.find_by(id: params[:id])
    @lession.destroy
    flash[:success]=  "delete lession success!!!"
    redirect_to request.referrer || root_url
  end

  private
  def lession_params
    params.require(:lession).permit(:name, :category_id, :content)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.is_admin?
  end
end
