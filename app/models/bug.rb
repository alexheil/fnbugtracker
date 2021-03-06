class Bug < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: :slugged

  is_impressionable :counter_cache => true, :column_name => :view_count, :unique => :session_hash

  #include VideoUploader[:video]
  #include ImageUploader[:image]

  scope :popular, -> { order('view_count DESC') }
  scope :newest, -> { order("created_at DESC") }

  enum status: [:not_know, :aware, :in_progress, :next_patch, :live]

  belongs_to :user
  belongs_to :gamemode
  belongs_to :platform
  belongs_to :status

  validates :gamemode_id, presence: true
  validates :platform_id, presence: true
  validates :status_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  #validates :image_data, presence: true, unless: :image_data?
  #validates :video_data, presence: true, unless: :video_data?
  #validates :description, presence: true, length: { maximum: 5000 }

  before_save :generated_slug

  def self.search(search)
    where("title LIKE ?", "%#{search}%")
  end
    
  private

    def generated_slug
      require 'securerandom' 
      self.slug = SecureRandom.hex(16) if slug.blank?
    end

end
