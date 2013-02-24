class TestMastersController < ApplicationController
  # GET /test_masters
  # GET /test_masters.xml
    # before_filter :ensure_login
  
  def index
    @test_masters = TestMaster.all
	 @test_master = TestMaster.new
	 @test_master_last = TestMaster.last
	 
	 @user = current_user
	 if(@test_master_last)
		@test_master.test_id=@test_master_last.test_id.next
	 else
		@test_master.test_id="1"
	 end
          @clinic = @user.clinics
	 #@test_master.branch_code=@person.branch_name
	 #@test_master.branch_location=@person.branch_location
	 20.times{ @test_master.test_master_children.build }
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_masters }
    end
  end
  def sidebar
    render :layout => 'masteradmin' 
  end

  # GET /test_masters/1
  # GET /test_masters/1.xml
  def show
    @test_master = TestMaster.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_master }
    end
  end

  def list
	 @session = Session.find(session[:id])
   @person = Person.find(@session.person_id)
	 @test_masters = TestMaster.all(:order => "id DESC",:conditions => "branch_code = '#{@person.branch_name}'")
	 @button_name=params[:button_name]
   render :partial => "list"
  end

  # GET /test_masters/new
  # GET /test_masters/new.xml
  def new
    @test_master = TestMaster.new
	 @test_master_last = TestMaster.last
	 @session = Session.find(session[:id])
	 @person = Person.find(@session.person_id)
	 if(@test_master_last)
		@test_master.test_id=@test_master_last.test_id.next
	 else
		@test_master.test_id="1"
	 end
	 @test_master.branch_code=@person.branch_name
	 @test_master.branch_location=@person.branch_location
	 20.times{ @test_master.test_master_children.build }
	 render :partial => "new"
  end

  def add_new
	 
    @test_master = TestMaster.new
	 @test_master_last = TestMaster.last
	 @session = Session.find(session[:id])
	 @person = Person.find(@session.person_id)
	 if(@test_master_last)
		@test_master.test_id=@test_master_last.test_id.next
	 else
		@test_master.test_id="1"
	 end
	 @test_master.branch_code=@person.branch_name
	 @test_master.branch_location=@person.branch_location
	 20.times{ @test_master.test_master_children.build }
	 render :layout => "application"
  end

  # GET /test_masters/1/edit
  def edit
    @test_master = TestMaster.find(params[:id])
	 @session = Session.find(session[:id])
	 @person = Person.find(@session.person_id)
	 20.times{ @test_master.test_master_children.build }
  end

  # POST /test_masters
  # POST /test_masters.xml
  def create
    @test_master = TestMaster.new(params[:test_master])
  end

  # PUT /test_masters/1
  # PUT /test_masters/1.xml
  def update
    @test_master = TestMaster.find(params[:id])
  end

  # DELETE /test_masters/1
  # DELETE /test_masters/1.xml
  def destroy
    @test_master = TestMaster.find(params[:id])
    @test_master.destroy
	 @session = Session.find(session[:id])
    @person = Person.find(@session.person_id)
	 @test_masters = TestMaster.all(:order => "id DESC",:conditions => "branch_code = '#{@person.branch_name}'")
    @button_name="delete"
	 render :partial => "list"
  end
  
  def tests_list
   @session = Session.find(session[:id])
   @person = Person.find(@session.person_id)
   @test_masters = TestMaster.all(:order => "id DESC",:conditions => "branch_code = '#{@person.branch_name}'")
  end

def params_clone
  	@test_master=TestMaster.find(:all)
  end
  
    def test_search_result
    @test=params[:test_name].split('==>')[1]
    @test_master=TestMaster.find_by_sql("select t.test_name,tc.* from test_masters t inner join test_master_children tc on tc.test_master_id=t.id where test_id = '#{@test}'")

		render :partial => "test_search_results"
  end
  


  def get_tests
@test=TestMaster.find_by_test_id(params[:test_id])
		    str=""
		for test in @test.test_master_children
		str << test.parameter.to_s+"<sub_division>"+test.normal_range.to_s+"<sub_division>"+test.units.to_s+"<division_sub>"
		end
		render :text => str
		
  end

end
