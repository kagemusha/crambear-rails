class CardSet < ActiveRecord::Base
	belongs_to :user
	has_many :cards, :order=>"updated_at desc", :dependent => :destroy
  has_many :results, :dependent => :destroy
  has_many :labels, :dependent => :destroy
  default_scope :order => 'updated_at DESC'
  attr_accessible :name, :description, :cards_count

  def self.myType
    "card_set"
  end
  
  def self.after_create
    if (labels ||= UserSetting.find_by_key("default_labels"))
      labels.value.split(',').each do |label|
        self.labels << Label.new(:name=>label)
      end
    end
    save
  end

  def active_count
    self.cards.where("archived=false").count
  end

end
