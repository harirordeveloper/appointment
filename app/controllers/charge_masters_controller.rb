class ChargeMastersController < ApplicationController
  # GET /charge_masters
  # GET /charge_masters.xml
 # before_filter :ensure_login
  layout 'application'
  def index
	 @session = Session.find(session[:id])
	 @person = Person.find(@session.person_id)
    @charge_masters = ChargeMaster.all
	 @charge_master = ChargeMaster.new
	 @charge_master.branch_code=@person.branch_name
	 @charge_master.branch_location=@person.branch_location
	 @collection_centers=CollectionCenter.all(:conditions => "branch_code = '#{@person.branch_name}' and discontinued !='1' ")
	 @referral_clinics=ReferralClinic.all(:conditions => "discontinued !='1' ")
	 i=0
	
	 (@collection_centers.length+10).times{
	 	@collection_charge=@charge_master.collection_centers_charges.build
		if(@collection_centers[i])
			@collection_charge.s_no=i+1
			@collection_charge.center_id=@collection_centers[i].id
			@collection_charge.name=@collection_centers[i].name
		end
		i+=1
    }
	 i=0
	 (@referral_clinics.length+10).times{
	 	@referral_charge=@charge_master.referral_charges.build
		if(@referral_clinics[i])
			@referral_charge.s_no=i+1
			@referral_charge.referral_id=@referral_clinics[i].id
			@referral_charge.name=@referral_clinics[i].name
		end
		i+=1
    }


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @charge_masters }
    end
  end

  # GET /charge_masters/1
  # GET /charge_masters/1.xml
  def show
    @charge_master = ChargeMaster.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @charge_master }
    end
  end

  def list
	@session_id=session[:id]
	@session = Session.find(session[:id])
	@people = Person.find(@session.person_id)
	@charge_masters = ChargeMaster.all(:order => "id DESC",:conditions => "branch_code='#{@people.branch_name}'")
	@button_name=params[:button_name]
   render :partial => "list"
  end

  # GET /charge_masters/new
  # GET /charge_masters/new.xml
  def new
	 @session = Session.find(session[:id])
	 @person = Person.find(@session.person_id)
    @charge_master = ChargeMaster.new
	 @charge_master.branch_code=@person.branch_name
	 @charge_master.branch_location=@person.branch_location
	 @collection_centers=CollectionCenter.all(:conditions => "branch_code = '#{@person.branch_name}' and discontinued !='1' ")
	 @referral_clinics=ReferralClinic.all(:conditions => "discontinued !='1' ")
	 i=0
	
	 (@collection_centers.length+10).times{
	 	@collection_charge=@charge_master.collection_centers_charges.build
		if(@collection_centers[i])
			@collection_charge.s_no=i+1
			@collection_charge.center_id=@collection_centers[i].id
			@collection_charge.name=@collection_centers[i].name
		end
		i+=1
    }
	 i=0
	 (@referral_clinics.length+10).times{
	 	@referral_charge=@charge_master.referral_charges.build
		if(@referral_clinics[i])
			@referral_charge.s_no=i+1
			@referral_charge.referral_id=@referral_clinics[i].code
			@referral_charge.name=@referral_clinics[i].name
		end
		i+=1
    }
	 render :partial => "new"
  end

  # GET /charge_masters/1/edit
def edit
@session = Session.find(session[:id])
@person = Person.find(@session.person_id)
@collection_centers=CollectionCenter.all(:conditions => "branch_code = '#{@person.branch_name}' and discontinued !='1' ")
@referral_clinics=ReferralClinic.all(:conditions => "discontinued !='1' ")
i=0
@charge_master=ChargeMaster.find(params[:id])
@charge_masters=ChargeMaster.find_by_sql("SELECT a.number,a.name,collect,a.mobile,a.price,a.name,a.discount,a.discount_amt,a.cost,b.* FROM (SELECT cc.id number,cc.name collect,cc.mobile,cm.charge_master_id master, CASE WHEN cc.id = cm.center_id THEN cm.price ELSE  '0' END AS price,cm.name,cm.discount_per discount,cm.discount_amt,cm.cost FROM collection_centers cc LEFT OUTER JOIN collection_centers_charges cm ON cc.id = cm.center_id AND cm.charge_master_id ='#{params[:id]}' GROUP BY cc.id ORDER BY  `cc`.`id` ASC ) a LEFT OUTER JOIN charge_masters b on b.id=a.master where a.name is null")
(@charge_masters.length).times{
 	@collection_charge=@charge_master.collection_centers_charges.build
#	@collection_charge.s_no=s_no+1
	@collection_charge.center_id=@charge_masters[i].number
	@collection_charge.name=@charge_masters[i].collect
	i+=1
    }
   
@charge_masters=ChargeMaster.find_by_sql("SELECT a.number,a.name,collect,a.mobile,a.price,a.name,a.discount,a.commission_amt,a.cost,b.*
FROM
(SELECT rc.id number,rc.name collect,rc.mobile,rch.charge_master_id master, 
CASE WHEN rc.id = rch.referral_id
THEN rch.price
ELSE  '0'
END AS price,rch.name,rch.commission_per discount,rch.commission_amt,rch.cost
FROM referral_clinics rc
LEFT OUTER JOIN referral_charges rch ON rc.id = rch.referral_id
AND rch.charge_master_id ='#{params[:id]}' AND rc.discontinued=0 
GROUP BY rc.id
ORDER BY  `rc`.`id` ASC ) a
LEFT OUTER JOIN charge_masters b on b.id=a.master
where a.name is null")  
   i=0
	 (@charge_masters.length).times{
	 	@referral_charge=@charge_master.referral_charges.build
			#@referral_charge.s_no=i+1
			@referral_charge.referral_id=@charge_masters[i].number
			@referral_charge.name=@charge_masters[i].collect
		i+=1
    }   
  end


  # POST /charge_masters
  # POST /charge_masters.xml
  def create
    @charge_master = ChargeMaster.new(params[:charge_master])
  end

  # PUT /charge_masters/1
  # PUT /charge_masters/1.xml
  def update
    @charge_master = ChargeMaster.find(params[:id])
  end

  # DELETE /charge_masters/1
  # DELETE /charge_masters/1.xml
  def destroy
    @charge_master = ChargeMaster.find(params[:id])
    @charge_master.destroy

    @session = Session.find(session[:id])
    @person = Person.find(@session.person_id)
    @charge_masters = ChargeMaster.all(:order => "id DESC",:conditions => "branch_code LIKE '#{@person.branch_name}%'")
    @button_name="delete"
    
	 render :partial => "list"
  end

  def get_sub_groups
	 str=""
	 test_sub_groups=TestSubGroup.all(:conditions => "test_group_id='#{params[:id]}'")
	 for test_sub_group in test_sub_groups
		str << test_sub_group.sub_group_name+"<sub_division>"+test_sub_group.id.to_s+"<division>"
	 end	
	 render :text => str
  end

  
  def get_tests_by_charge_master
	 str=""
	 test_masters=TestMaster.all(:conditions => "test_sub_group_id='#{params[:id]}'")
	 for test_master in test_masters
	   charge_master=ChargeMaster.find_by_test_master_id(test_master.id)
	   if(!charge_master)
  	   str << test_master.test_name+"<sub_division>"+test_master.id.to_s+"<division>"
  	 end  
	 end	
	 render :text => str
  end
  
  def get_tests
   str=""
   test_masters=TestMaster.all(:conditions => "test_sub_group_id='#{params[:id]}'")
   for test_master in test_masters
       str << test_master.test_name+"<sub_division>"+test_master.id.to_s+"<division>"  
   end  
   render :text => str
  end
end
