class Sentence < ActiveRecord::Base
  belongs_to :test, dependent: :destroy
  belongs_to :quessions
  belongs_to :answer
end
