class User < ActiveRecord::Base
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :photo, PhotoUploader
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy

  has_many :passive_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy


  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower



  def follow(user)
    active_follows.create(followed_id: user.id)
  end

  def unfollow(user)
    active_follows.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end

end