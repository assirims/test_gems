class Tag < ApplicationRecord
  has_many :course_tags, dependent: :destroy
  has_many :courses, through: :course_tags

	validates :name, length: {minimum: 1, maximum: 25}, uniqueness: true

  def to_s
		name
	end

	def popular_name
	  "#{name.to_s}: #{course_tags_count.to_s}"
	end

	def self.ransackable_attributes(auth_object = nil)
    ["course_tags_count", "id", "name"]
  end

	def self.ransackable_associations(auth_object = nil)
		["course_tags", "courses"]
	end

end
