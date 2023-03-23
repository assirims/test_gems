class Course < ApplicationRecord
  validates :title, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: { minimum: 5 }
  has_rich_text :description

  belongs_to :user

  def to_s
    title
  end

  # friendly_id
  extend FriendlyId

  # this is the default where the slug is generated from the title
  friendly_id :title, use: :slugged

  # this is the custom where the slug is generated from the random_slug method
  # friendly_id :generate_slug, use: :slugged
  # def generate_slug
  #   require 'securerandom'
  #   @random_slug ||= persisted? ? friendly_id : SecureRandom.hex(4)
  # end

  # def to_s
  #   slug
  # end

  LANGUAGES = ["English", "Russian", "Polish", "Spanish"]
  def self.languages
    LANGUAGES.map { |language| language }
  end

  LEVELS = ["Beginner", "Intermediate", "Advanced"]
  def self.levels
    LEVELS.map { |level| level }
  end

  # ransack search attributes
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "language", "level", "price", "short_description", "slug", "title", "updated_at"]
  end
end
