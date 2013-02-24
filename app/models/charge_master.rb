class ChargeMaster < ActiveRecord::Base

	has_many :collection_centers_charges, :dependent => :destroy
	accepts_nested_attributes_for :collection_centers_charges, :allow_destroy => :true, :reject_if => proc { |attrs| attrs.all? { attrs[:name].blank? } }	

	has_many :referral_charges, :dependent => :destroy
	accepts_nested_attributes_for :referral_charges, :allow_destroy => :true, :reject_if => proc { |attrs| attrs.all? { attrs[:name].blank? } }	

	validate do |charge_master|
		charge_master.errors.add_to_base("Please select group") if charge_master.test_group_id.blank?
		charge_master.errors.add_to_base("Please select Sub group") if charge_master.test_sub_group_id.blank?	
	  charge_master.errors.add_to_base("Please select test name") if charge_master.test_master_id.blank?	
		charge_master.errors.add_to_base("Please enter price") if charge_master.price.blank?	
  end

end
