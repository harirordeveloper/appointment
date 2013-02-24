class TestGroup < ActiveRecord::Base
	
	has_many :test_sub_groups
	validate do |test_group|
		test_group.errors.add_to_base("Please enter Department") if test_group.department.blank?	
		test_group.errors.add_to_base("Please enter group name") if test_group.group_name.blank?	

	end
end
