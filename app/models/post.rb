class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :image, presence: true
  validates :content, length: { minimum: 4 }
  validates :content, length: { maximum: 350 }
  belongs_to :user
  has_attached_file :image, styles: { :medium => "640x" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
