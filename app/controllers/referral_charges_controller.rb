class ReferralChargesController < ApplicationController
  # GET /referral_charges
  # GET /referral_charges.xml
  def index
    @referral_charges = ReferralCharge.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @referral_charges }
    end
  end

  # GET /referral_charges/1
  # GET /referral_charges/1.xml
  def show
    @referral_charge = ReferralCharge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @referral_charge }
    end
  end

  # GET /referral_charges/new
  # GET /referral_charges/new.xml
  def new
    @referral_charge = ReferralCharge.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @referral_charge }
    end
  end

  # GET /referral_charges/1/edit
  def edit
    @referral_charge = ReferralCharge.find(params[:id])
  end

  # POST /referral_charges
  # POST /referral_charges.xml
  def create
    @referral_charge = ReferralCharge.new(params[:referral_charge])

    respond_to do |format|
      if @referral_charge.save
        format.html { redirect_to(@referral_charge, :notice => 'ReferralCharge was successfully created.') }
        format.xml  { render :xml => @referral_charge, :status => :created, :location => @referral_charge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @referral_charge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /referral_charges/1
  # PUT /referral_charges/1.xml
  def update
    @referral_charge = ReferralCharge.find(params[:id])

    respond_to do |format|
      if @referral_charge.update_attributes(params[:referral_charge])
        format.html { redirect_to(@referral_charge, :notice => 'ReferralCharge was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @referral_charge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /referral_charges/1
  # DELETE /referral_charges/1.xml
  def destroy
    @referral_charge = ReferralCharge.find(params[:id])
    @referral_charge.destroy

    respond_to do |format|
      format.html { redirect_to(referral_charges_url) }
      format.xml  { head :ok }
    end
  end
end
