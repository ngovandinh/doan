class Lession < ActiveRecord::Base
  has_many :quessions, dependent: :destroy

  validates :content, presence: true , length: { maximum: Settings.max_content },
    uniqueness: { case_sensitive: false }
end
