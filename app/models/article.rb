class Article < ApplicationRecord

	mount_uploader :image, ImageUploader

	validates  :title, presence: true, length: { minimum:5 }
	has_many :comments, dependent: :destroy
	has_many :likes
	has_many :users, through: :likes

	belongs_to :author, class_name: 'User'
  
  def tags=(value)
  	value = sanitize_tags(value) if value.is_a?(String)
    super(value)	
  end

  private

  def sanitize_tags(text)
    text.downcase.split.uniq
  end
  
end
