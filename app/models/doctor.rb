class Doctor < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  has_secure_password
  has_many :patients
  has_many :meds, through: :patients

end
