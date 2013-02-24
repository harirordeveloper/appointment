class TestSubGroup < ActiveRecord::Base
	validate do |test_sub_group|
		test_sub_group.errors.add_to_base("Please enter group name") if test_sub_group.test_group_id.blank?	
	   test_sub_group.errors.add_to_base("Please enter sub group name") if test_sub_group.sub_group_name.blank?	
	end
end
