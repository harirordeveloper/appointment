class TestGroupsController < ApplicationController
  # GET /test_groups
  # GET /test_groups.xml
    # before_filter :ensure_login
  layout 'masteradmin'
  def index
    @test_groups = TestGroup.all
  @test_group = TestGroup.new
     @test_group_last = TestGroup.last

  @user = current_user
   
   if(@test_group_last)
    @test_group.group_id=@test_group_last.group_id.next
   else
    @test_group.group_id="1"
   end
   @clinic = @user.clinics
   #@test_group.branch_code=@person.branch_name
   #@test_group.branch_location=@person.branch_location

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_groups }
    end
  end

  # GET /test_groups/1
  # GET /test_groups/1.xml
  def show
    @test_group = TestGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_group }
    end
  end

 def list
  @test_group = TestGroup.all(:order => "id DESC")
  @button_name=params[:button_name]
   render :partial => "list"
  end

  # GET /test_groups/new
  # GET /test_groups/new.xml
  def new
   @test_group = TestGroup.new
   @test_group_last = TestGroup.last
   @session = Session.find(session[:id])
   @person = Person.find(@session.person_id)
   if(@test_group_last)
    @test_group.group_id=@test_group_last.group_id.next
   else
    @test_group.group_id="1"
   end
   @test_group.branch_code=@person.branch_name
   @test_group.branch_location=@person.branch_location
   render :partial => "new"

  end

  # GET /test_groups/1/edit
  def edit
   @session_id=session[:id]
  	@session = Session.find(session[:id])
  	@person = Person.find(@session.person_id)
  	@test_group = TestGroup.find(params[:id])
  	render :partial => "edit"
  end

  # POST /test_groups
  # POST /test_groups.xml
  def create
    @test_group = TestGroup.new(params[:test_group])

    
  end

def list
  @session = Session.find(session[:id])
  @person = Person.find(@session.person_id)
  @test_groups = TestGroup.all(:order => "id DESC",:conditions => "branch_code LIKE '#{@person.branch_name}%'")
  @button_name=params[:button_name]
  render :partial => "list"
  end

  # PUT /test_groups/1
  # PUT /test_groups/1.xml
  def update
    @test_group = TestGroup.find(params[:id])
  end

  # DELETE /test_groups/1
  # DELETE /test_groups/1.xml
  def destroy
    @test_group = TestGroup.find(params[:id])
    @test_group.destroy
	 @session = Session.find(session[:id])
    @person = Person.find(@session.person_id)
    @test_groups = TestGroup.all(:order => "id DESC",:conditions => "branch_code LIKE '#{@person.branch_name}%'")
    @button_name="delete"
	 render :partial => "list"
  end
end
