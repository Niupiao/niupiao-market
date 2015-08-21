class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :subitem, :polymorphic => true
  
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :likers, foreign_key: "user_id", class_name: "User"
  has_many :comments, dependent: :destroy
  
  attr_accessor :VALID_ITEM_TYPES 
  serialize :tags, Array
    
  validates_presence_of :name
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  
  def supercategorize(category_name)
    beauty = %w(Makeup SkinCare Fragrance BathAndBody Nails Hair)
    baby = %w(BabyAndToddlerClothing Feeding Diapering BeddingAndDecor Seating ActivitiesAndToys
              HealthAndSafety)
    if beauty.include? category_name
      self.supercategory_id = 1
    elsif baby.include? category_name
      self.supercategory_id = 2
    end
    self.save!
    Supercategory.find_by(id: self.supercategory_id)
  end
  
  def categorize(table_name)
    makeup = %w(FaceMakeup EyeMakeup Lips ToolsAndBags)
    skincare = %w(Cleanse Moisturize Treatments)
    fragrance = %w(Women Men)
    bathbody = %w(LotionsAndCreams ShowerAndBath Suncare)
    nails = %w(NailPolish KitsSets SpecialEffects TreatmentsAndTools)
    hair = %w(StylingProductsAndTools ShampooAndConditioner)
    babytoddlerclothing = %w(BoysClothing GirlsClothing Accessories UnderwearAndSocks)
    feeding = %w(Beverages Food BabyFormula FeedingAccessories BoosterSeats)
    diapering = %w(DiaperAccessories Diapers)
    beddingdecor = %w(LampAndNightLights BeddingSeparates BeddingSet WallDecorations)
    seating = %w(BoosterCarSeats CarSeatAccessories TravelSets Strollers BoosterFeedingSeats PottySeatsAndStepStools)
    activitiesandtoys = %w(Bikes SleepingToys GymsAndPlaymats LearningToys Toys)
    healthandsafety = %w(Gates BabyMonitors BabyProofingItems GroomingHealthcareAndSkincareEssentials)
    
    if makeup.include? table_name
      self.category_id = 1
    elsif skincare.include? table_name
      self.category_id = 2
    elsif fragrance.include? table_name
      self.category_id = 3
    elsif bathbody.include? table_name
      self.category_id = 4
    elsif nails.include? table_name
      self.category_id = 5
    elsif hair.include? table_name
      self.category_id = 6
    elsif babytoddlerclothing.include? table_name
      self.category_id = 7
    elsif feeding.include? table_name
      self.category_id = 8
    elsif diapering.include? table_name
      self.category_id = 9
    elsif beddingdecor.include? table_name
      self.category_id = 10
    elsif seating.include? table_name
      self.category_id = 11
    elsif activitiesandtoys.include? table_name
      self.category_id = 12
    elsif healthandsafety.include? table_name
      self.category_id = 13
    end
    self.save!
    Category.find_by(id: self.category_id)
  end
end
