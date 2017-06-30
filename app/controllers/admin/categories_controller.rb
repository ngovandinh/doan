class Admin::CategoriesController < ApplicationController
  layout "admin"
  def index
     @categories= Category.paginate(page: params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created!"
      redirect_to action: :index
    else
      flash[:danger] = "Category is unvalid!"
      render action: :new
    end
  end


  def edit
    @category = Category.find_by(id: params[:id])
  end

  def update
    @category = Category.find_by(id: params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "update category success!!!"
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    @category.destroy
    flash[:success]=  "delete category success!!!"
    redirect_to request.referrer || root_url
  end


  private
  def category_params
    params.require(:category).permit(:name)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.is_admin?
  end
end
