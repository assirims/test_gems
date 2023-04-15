# Preview all emails at http://localhost:3000/rails/mailers/enrollment_mailer
# http://10.0.0.8:8080/rails/mailers/enrollment_mailer
class EnrollmentMailerPreview < ActionMailer::Preview

  def new_enrollment
    EnrollmentMailer.new_enrollment(Enrollment.first).deliver_now
  end

end
