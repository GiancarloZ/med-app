class Meds < ActiveRecord::Base
  has_many :patient_meds
  has_many :patients, through: :patient_meds

end
