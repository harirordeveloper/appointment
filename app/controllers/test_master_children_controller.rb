class TestMasterChildrenController < ApplicationController
  # GET /test_master_children
  # GET /test_master_children.xml
  def index
    @test_master_children = TestMasterChild.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_master_children }
    end
  end

  # GET /test_master_children/1
  # GET /test_master_children/1.xml
  def show
    @test_master_child = TestMasterChild.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_master_child }
    end
  end

  # GET /test_master_children/new
  # GET /test_master_children/new.xml
  def new
    @test_master_child = TestMasterChild.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_master_child }
    end
  end

  # GET /test_master_children/1/edit
  def edit
    @test_master_child = TestMasterChild.find(params[:id])
  end

  # POST /test_master_children
  # POST /test_master_children.xml
  def create
    @test_master_child = TestMasterChild.new(params[:test_master_child])

    respond_to do |format|
      if @test_master_child.save
        format.html { redirect_to(@test_master_child, :notice => 'TestMasterChild was successfully created.') }
        format.xml  { render :xml => @test_master_child, :status => :created, :location => @test_master_child }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_master_child.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_master_children/1
  # PUT /test_master_children/1.xml
  def update
    @test_master_child = TestMasterChild.find(params[:id])

    respond_to do |format|
      if @test_master_child.update_attributes(params[:test_master_child])
        format.html { redirect_to(@test_master_child, :notice => 'TestMasterChild was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test_master_child.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_master_children/1
  # DELETE /test_master_children/1.xml
  def destroy
    @test_master_child = TestMasterChild.find(params[:id])
    @test_master_child.destroy

    respond_to do |format|
      format.html { redirect_to(test_master_children_url) }
      format.xml  { head :ok }
    end
  end
end
