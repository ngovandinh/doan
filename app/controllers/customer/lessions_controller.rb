class Customer::LessionsController < ApplicationController
  def show
    @lession = Lession.find(params[:id])
  end
  def search
    if !params[:search_form].nil?
      @lessions = Lession.search(params[:search_form][:condition])
    else
      @words = Word.search
    end
    respond_to do |format|
      format.html { render 'search' }
      format.js
    end
  end
end
