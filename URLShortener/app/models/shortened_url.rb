class ShortenedURL < ActiveRecord::Base
  validates :user_id, :long_url, :short_url, null: false
  validates :long_url, :short_url, uniqueness: true

  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: "User"

  has_many :visits,
  primary_key: :id,
  foreign_key: :url_id,
  class_name: "Visit"


  def self.random_code
    secure = SecureRandom.base64(16)
    while ShortenedURL.exists?(:short_url => secure)
      secure = SecureRandom.base64(16)
    end
    secure
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedURL.create(user_id: user.id, long_url: long_url, short_url: ShortenedURL.random_code)
  end

  def num_clicks
    visits.select(:id).count
  end

  def num_uniques
    visits.select(:visitor_id).distinct.count
  end

  def num_recent_uniques
    visits.select(:visitor_id).where("created_at > ?", 10.minutes.ago).distinct.count
  end



end
