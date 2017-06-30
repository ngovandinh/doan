class Customer::SentencesController < ApplicationController
  before_action :correct_user
  before_action :valid_sentence
  def update
    @sentence.update_attributes(sentence_params)
    redirect_to start_customer_test_path(@sentence.test)
  end

  private
    def sentence_params
      params.require(:sentence).permit(:answer_id)

    end

    def valid_sentence
      finnished_time = Time.zone.now
      if @sentence.test.status.eql?('finnished') || (finnished_time > (@sentence.test.started_at + Settings.doing_time.second))
        flash[:danger] = "Test is submitted or time out"
        redirect_to request.referrer
      end
    end

    def correct_user
      @sentence = Sentence.find(params[:id])
      redirect_to(root_url) unless current_user?(@sentence.test.user)
    end
end
