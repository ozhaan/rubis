class Article < ApplicationRecord
  belongs_to :category
  has_many :sections, -> { order('sequence') }, inverse_of: :article, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  enum status: %i[published draft]

  validates :title, presence: true
  validates :identifier, presence: true, uniqueness: true, format: /\A[A-Za-z0-9\_]+\Z/

  scope :open, -> { where(status: Article.statuses[:published]).where('published_at <= ?', Time.current) }
end
