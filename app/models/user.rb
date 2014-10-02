class User < ActiveRecord::Base
  has_many :invites, dependent: :nullify
  has_many :projects, foreign_key: 'owner_id', dependent: :nullify
  has_many :comments, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
