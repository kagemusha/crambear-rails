class User < ActiveRecord::Base
  rolify
  has_many :user_labels, :dependent => :destroy
  has_many :card_sets, :dependent => :destroy
  has_many :results, :dependent => :destroy
  has_many :cards, :through=>:card_sets
  has_many :labels, :through=>:card_sets

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
end
