class Patient < ActiveRecord::Base
  belongs_to :doctor
  has_many :patient_meds
  has_many :meds, through: :patient_meds

end
