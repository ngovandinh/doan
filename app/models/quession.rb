class Quession < ActiveRecord::Base
  belongs_to :lession

  has_many :sentences, dependent: :destroy
  validates :lession, presence: true
  validates :content, presence: true

  has_many :answers , dependent:   :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true
  # validates_associated :answers
  validate :must_have_correct_checked

  # def self.search(user_id, category_id = '' ,condition_search = '')
  #   lession_ids = "select id from lessions where user_id = #{user_id}"
  #   word_ids = "select word_id from quessions where lession_id in (#{lession_ids})"
  #   if "learned".eql?(condition_search)
  #     return ''.eql?(category_id) ? Word.where("id in (#{word_ids})") :
  #     Word.where("id in (#{word_ids}) and category_id = #{category_id}")
  #   elsif "unlearned".eql?(condition_search)
  #     return ''.eql?(category_id) ? Word.where("id not in (#{word_ids})") :
  #     Word.where("id not in (#{word_ids}) and category_id = #{category_id}")
  #   else
  #     return ''.eql?(category_id) ? Word.all : Word.where("category_id = #{category_id}")
  #   end
  # end

  def meaning
    self.answers.each do |answer|
      if answer.is_correct
        return answer.content
      end
    end
    return "can't find"
  end




  private
    def must_have_correct_checked
      self.answers.each do |answer|
        if answer.is_correct
          return true
        end
      end
      errors.add(:is_correct,"must have correct answer!!!")
    end
end
