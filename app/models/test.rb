class Test < ActiveRecord::Base
  belongs_to :user
  belongs_to :lession

  has_many :sentences, dependent: :destroy

  accepts_nested_attributes_for :sentences
  # validates_associated :sentences

  def result
    count = 0
    self.sentences.each do |sentence|
      if !sentences.answer.nil? && sentences.answer.is_correct
        count += 1
      end
    end
    return count
  end

  def make_random_questions(lession_id = "")
     if "".eql?(lession_id)
      quessions = Quession.order("RANDOM()").limit(Settings.number_of_quession)
     else
      quessions = Quession.where(lession_id: lession_id).order("RANDOM()").
        limit(Settings.number_of_quession)
     end

      quessions.each do |quession|
        self.sentences.create(quession_id: quession.id)
      end
  end

end
