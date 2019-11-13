class PatientMeds < ActiveRecord::Base
  belongs_to :patient
  belongs_to :meds

end
  
