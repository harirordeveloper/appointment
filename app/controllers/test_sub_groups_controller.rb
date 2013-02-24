class TestSubGroupsController < ApplicationController
  # GET /test_sub_groups
  # GET /test_sub_groups.xml
  #before_filter :ensure_login
  layout 'application'
  def index
   
  @test_sub_groups = TestSubGroup.all
  @test_sub_group = TestSubGroup.new
     @test_sub_group_last = TestSubGroup.last

   @session = Session.find(session[:id])
   @person = Person.find(@session.person_id)
   
   if(@test_sub_group_last)
    @test_sub_group.sub_group_id=@test_sub_group_last.sub_group_id.next
   else
    @test_sub_group.sub_group_id="1"
   end

   @test_sub_group.branch_code=@person.branch_name
   @test_sub_group.branch_location=@person.branch_location

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_sub_groups }
    end
  end

  # GET /test_sub_groups/1
  # GET /test_sub_groups/1.xml
  def show
    @test_sub_group = TestSubGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_sub_group }
    end
  end

  # GET /test_sub_groups/new
  # GET /test_sub_groups/new.xml
 def list
  @test_sub_group = TestSubGroup.all(:order => "id DESC")
  @button_name=params[:button_name]
   render :partial => "list"
  end

  # GET /test_sub_groups/new
  # GET /test_sub_groups/new.xml
  def new
   @test_sub_group = TestSubGroup.new
   @test_sub_group_last = TestSubGroup.last
   @session = Session.find(session[:id])
   @person = Person.find(@session.person_id)
   if(@test_sub_group_last)
   	@test_sub_group.sub_group_id=@test_sub_group_last.sub_group_id.next
   else
    	@test_sub_group.sub_group_id="1"
   end
   @test_sub_group.branch_code=@person.branch_name
   @test_sub_group.branch_location=@person.branch_location
   render :partial => "new"

  end


  # GET /test_sub_groups/1/edit
  def edit
   @session_id=session[:id]
  	@session = Session.find(session[:id])
  	@person = Person.find(@session.person_id)
  	@test_sub_group = TestSubGroup.find_by_id(params[:id])
  render :partial => "edit"
  end

  # POST /test_sub_groups
  # POST /test_sub_groups.xml
  def create
    @test_sub_group = TestSubGroup.new(params[:test_sub_group])
   end

  def list
    @session = Session.find(session[:id])
  	 @person = Person.find(@session.person_id)
    @test_sub_groups = TestSubGroup.all(:order => "id DESC",:conditions => "branch_code LIKE '#{@person.branch_name}%'")
    @button_name=params[:button_name]
    render :partial => "list"
  end

  # PUT /test_sub_groups/1
  # PUT /test_sub_groups/1.xml
  def update
    @test_sub_group = TestSubGroup.find(params[:id])
  end

  # DELETE /test_sub_groups/1
  # DELETE /test_sub_groups/1.xml
  def destroy
    @test_sub_group = TestSubGroup.find(params[:id])
    @test_sub_group.destroy
    @session = Session.find(session[:id])
  	 @person = Person.find(@session.person_id)
    @test_sub_groups = TestSubGroup.all(:order => "id DESC",:conditions => "branch_code LIKE '#{@person.branch_name}%'")
    @button_name="delete"
	 render :partial => "list"
  end
end
