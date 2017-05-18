class Sentence < ActiveRecord::Base
  belongs_to :test, dependent: :destroy
  belongs_to :quession
  belongs_to :answer
end
