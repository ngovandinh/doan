class Answer < ActiveRecord::Base
  belongs_to :quession

  validates :content,  presence: true
end
