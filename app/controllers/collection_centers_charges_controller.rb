class CollectionCentersChargesController < ApplicationController
  # GET /collection_centers_charges
  # GET /collection_centers_charges.xml
  def index
    @collection_centers_charges = CollectionCentersCharge.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @collection_centers_charges }
    end
  end

  # GET /collection_centers_charges/1
  # GET /collection_centers_charges/1.xml
  def show
    @collection_centers_charge = CollectionCentersCharge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @collection_centers_charge }
    end
  end

  # GET /collection_centers_charges/new
  # GET /collection_centers_charges/new.xml
  def new
    @collection_centers_charge = CollectionCentersCharge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @collection_centers_charge }
    end
  end

  # GET /collection_centers_charges/1/edit
  def edit
    @collection_centers_charge = CollectionCentersCharge.find(params[:id])
  end

  # POST /collection_centers_charges
  # POST /collection_centers_charges.xml
  def create
    @collection_centers_charge = CollectionCentersCharge.new(params[:collection_centers_charge])

    respond_to do |format|
      if @collection_centers_charge.save
        format.html { redirect_to(@collection_centers_charge, :notice => 'CollectionCentersCharge was successfully created.') }
        format.xml  { render :xml => @collection_centers_charge, :status => :created, :location => @collection_centers_charge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @collection_centers_charge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /collection_centers_charges/1
  # PUT /collection_centers_charges/1.xml
  def update
    @collection_centers_charge = CollectionCentersCharge.find(params[:id])

    respond_to do |format|
      if @collection_centers_charge.update_attributes(params[:collection_centers_charge])
        format.html { redirect_to(@collection_centers_charge, :notice => 'CollectionCentersCharge was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @collection_centers_charge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /collection_centers_charges/1
  # DELETE /collection_centers_charges/1.xml
  def destroy
    @collection_centers_charge = CollectionCentersCharge.find(params[:id])
    @collection_centers_charge.destroy

    respond_to do |format|
      format.html { redirect_to(collection_centers_charges_url) }
      format.xml  { head :ok }
    end
  end
end
