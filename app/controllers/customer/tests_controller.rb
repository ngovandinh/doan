class Customer::TestsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user , only: [:start, :finnish]

  def index
    @tests = current_user.tests.paginate(page: params[:page], per_page: Settings.number_of_page)
  end

  def create
    @test= current_user.tests.build(test_params)
    if @test.save
      @test.make_random_questions(test_params[:lession_id])
      redirect_to  start_customer_test_path(@test)
    else
      redirect_to root_path
    end
  end

  def start
    if @test.status.eql?('none')
      @test.update_attribute('status','started')
      @test.update_attribute('started_at', Time.zone.now)
      # elsif @test.status.eql?('started') && Time.zone.now < (test.started_at + Settings.doing_time.second)
      # doing somthing
    end
    @remaining_time = ((@test.started_at + Settings.doing_time.second) - Time.zone.now).round
    redirect_to result_customer_test_path(@test) if (@remaining_time <= 0 or @test.status.eql?('finnished'))
  end

  def update
  end

  def finnish
    finnished_time = Time.zone.now
    if @test.status.eql?('started') && (finnished_time <= (@test.started_at + Settings.doing_time.second))

      @test.update_attribute('status','finnished')
      @test.update_attribute('finnished_at', finnished_time)

      flash[:success] = "finnished success!!!!"
    else
      flash[:danger] = "The test is time out"
    end

    redirect_to result_customer_test_path(@test)

  end

  def result
    @test = Test.find(params[:id])
  end


  private

    def correct_user
      @test = Test.find(params[:id])
      redirect_to(root_url) unless current_user?(@test.user)
    end
    def test_params
      params.require(:test).permit!
    end
end
