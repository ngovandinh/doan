class Quession < ActiveRecord::Base
  belongs_to :lession

  # has_many :sentences, dependent: :destroy
  validates :lession, presence: true
  validates :content, presence: true

  has_many :answers , dependent: :destroy
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

  def import file
       CSV.foreach(file.path, headers: true, col_sep: "|", header_converters: :symbol) do |row|
         row = row.to_hash
         answers_attributes = []
         row[:answers].split(";").each do |answer|
           answer_hash = Hash.new
           arr_answer = answer.split(",")
           answer_hash[:content] = arr_answer[0]
           answer_hash[:is_correct] = arr_answer[1]
           answers_attributes.push answer_hash
         end
         row[:answers_attributes] = answers_attributes
         row.delete :answers
         Question.create! row
       end
  end

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
