class TestMaster < ActiveRecord::Base
	has_many :test_master_children, :dependent => :destroy
	accepts_nested_attributes_for :test_master_children, :allow_destroy => :true, :reject_if => proc { |attrs| attrs.all? { attrs[:normal_range].blank? } }	
  has_many :charge_masters
	validate do |test_master|
	test_master.errors.add_to_base("Please select group") if test_master.test_group_id.blank?
	test_master.errors.add_to_base("Please select Sub group") if test_master.test_sub_group_id.blank?	
	test_master.errors.add_to_base("Please enter test name") if test_master.test_name.blank?
	test_master.errors.add_to_base("Please enter Reporting Days") if test_master.report_collection_days.blank?
	test_master.errors.add_to_base("Please select Temp") if test_master.temp.empty?	
  end
end
