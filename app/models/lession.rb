class Lession < ActiveRecord::Base
  belongs_to :category
  has_many :quessions, dependent: :destroy

  validates :content, presence: true , length: { maximum: Settings.max_content },
    uniqueness: { case_sensitive: false }

  def self.search(condition_search = '')
    if "".eql?(condition_search)
      return Lession.all
    else
      return Lession.where("content like ?", "%#{condition_search}%")
    end
  end
end
