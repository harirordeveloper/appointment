class Clinic < ActiveRecord::Base
  belongs_to :country
  belongs_to :state
  belongs_to :city
  belongs_to :location
  has_many :consultants
  belongs_to :user
  attr_accessible :name, :pin, :state_id,:clinicbranches_attributes,:consultants_attributes,:address1, :address2, 
                  :altemail, :branches, :choosefile, :city_id, :cliniccode,
                  :country_id, :discontinue, :displayname, :email, :expdate,
                  :fax, :landmarks, :location_id,  :website,:clinic_timings_attributes,:user_id,:image

 has_many :clinicbranches, :dependent => :destroy
        accepts_nested_attributes_for :clinicbranches, :allow_destroy => :true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
 has_many :clinic_timings, :dependent => :destroy
        accepts_nested_attributes_for :clinic_timings, :allow_destroy => :true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  validates :name,:city,:presence => true
  validates :user_id, presence: true
  validates :name, :address1,:email,:city,:location,:expdate,:presence => true
  validates :pin, :length => { :is => 6 }
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

 
end
