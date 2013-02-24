class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def appointment_status(appointment)
        
    @appointment = appointment

    mail :to=>appointment.email,:subject=>"Your appointment has been booked "
  end
end
