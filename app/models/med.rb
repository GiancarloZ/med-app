class Med < ActiveRecord::Base
  validates :name, presence: true
  has_many :patient_meds
  has_many :patients, through: :patient_meds

end
