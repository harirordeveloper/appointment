class BookappointmentsController < ApplicationController
  # GET /bookappointments
  # GET /bookappointments.json
  def index
    @bookappointments = Bookappointment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookappointments }
    end
  end


  # GET /bookappointments/1
  # GET /bookappointments/1.json
  def show
    @bookappointment = Bookappointment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookappointment }
    end
  end

  # GET /bookappointments/new
  # GET /bookappointments/new.json
  def new

     $c = params[:clinic_id]
     $do = params[:doctor]
     $t = params[:time]
     $d = params[:date]

     @clinic_id = params[:clinic_id]       

     @clinic = Clinic.find_by_id("#{params[:clinic_id]}")

    @appointmentdetails = ConsultantMaster.find_by_id(params[:doctor])
    @doctor = ConsultantMaster.find_by_id("#{params[:doctor]}")
  
  
    timings = []
  @date = []
  @times = [[]]
  @times1 = [[]]
  @json = []
  yyyy= []
  mm= []
  dd= []
  epoch_seconds = []
  j=0
     for i in 0...364
      #To find the days sequentially from today to one week
      
           day = DateTime.now.next_day(i).strftime("%a")
      #find the timing object contains the doctor id and the day(ex:mon)
       
       timings[i] = DoctorTiming.find_by_consultant_master_id_and_day(@doctor.id,day.upcase)
      #split the date and pass it to year month and day
       yyyy[i], mm[i], dd[i] = $1, $2, $3 if DateTime.now.next_day(i).strftime("%Y-%m-%d").to_s =~ /(\d+)-(\d+)-(\d+)/
      #convert the given data into epoch seconds 
         @date[i] = Time.mktime(yyyy[i], mm[i], dd[i])
      epoch_seconds[i] = Time.mktime(yyyy[i], mm[i], dd[i]).tv_sec
	
	      #multiply the value with 1000 to equate it with jquery calender parameters   
	 
	          @json[i] =  epoch_seconds[i]*1000
	   end
       #this is to divide time into slices(15minutes each)
             
             k=0
        for j in 0...timings.length
               count = 0
            start_time=timings[j].morning_from 
		      while(start_time<timings[j].morning_to)
				@times[k+=1]=start_time.strftime("%R AM").to_s+" to "+(start_time+=15*60).strftime("%R AM").to_s#morning shift
		        count+=1
		         
		      end
       #divide the total array into slices using the count variable 
	      @all = @times.each_slice(count).to_a
        end
            l=0
        for m in 0...timings.length
               count = 0
            start_time=timings[m].evening_from 
		      while(start_time<timings[m].evening_to)
				@times1[l+=1]=start_time.strftime("%R PM").to_s+" to "+(start_time+=15*60).strftime("%R PM").to_s#evening shift
		        count+=1
		         
		      end
       #divide the total array into slices using the count variable 
	       @all1= @times1.each_slice(count).to_a

        end


     @appointment_time=params[:time]
     @appointment_date=params[:date]
      @appointment_clinic=Clinic.find_by_id(params[:clinic_id])
      
    @appointmentlocation=Clinic.find_by_id(params[:doctor])
    @bookappointment = Bookappointment.new
      
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookappointment }
    end
  end

  # GET /bookappointments/1/edit
  def edit
    @bookappointment = Bookappointment.find(params[:id])
  end

  # POST /bookappointments
  # POST /bookappointments.json
  def create
     @appointmentdetails = ConsultantMaster.find_by_id(params[:doctor])
     @appointment_time=params[:time]
     @appointment_date=params[:date]
     @appointment_clinic=Clinic.find_by_id(params[:clinic_id])
     @appointmentlocation=Clinic.find_by_id(params[:doctor])
     
      params[:clinic_id] = 1
      params[:doctor] = 1
    

    @bookappointment = Bookappointment.new(params[:bookappointment])
      @appointment = @bookappointment
    @bookappointment.clinic_id = $c
    @bookappointment.consultant_master_id = $do
   respond_to do |format| 
     if simple_captcha_valid? &&  @bookappointment.save
      Notifier.appointment_status(@appointment).deliver  
      format.html { redirect_to :action => "complete" }
            else
      
        format.html { redirect_to new_bookappointment_path({:clinic_id => $c, :doctor => $do, :time => $t, :date => $d}) }
        format.json { render json: @bookappointment.errors, status: :unprocessable_entity }
            
end
    end
end

   

  # PUT /bookappointments/1
  # PUT /bookappointments/1.json
  def update
    @bookappointment = Bookappointment.find(params[:id])

    respond_to do |format|
      if @bookappointment.update_attributes(params[:bookappointment])
        format.html { redirect_to @bookappointment, notice: 'Bookappointment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bookappointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookappointments/1
  # DELETE /bookappointments/1.json
 
def destroy
    @bookappointment = Bookappointment.find(params[:id])
    @bookappointment.destroy

    respond_to do |format|
      format.html { redirect_to bookappointments_url }
      format.json { head :no_content }
    end
  end

end
