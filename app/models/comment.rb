class Comment < ApplicationRecord

  belongs_to :user, counter_cache: true
  belongs_to :lesson, counter_cache: true

  validates :content, presence: true

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def to_s
    content
  end

end
