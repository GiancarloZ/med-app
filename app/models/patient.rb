class Patient < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  has_secure_password
  belongs_to :doctor
  has_many :patient_meds
  has_many :meds, through: :patient_meds

end
