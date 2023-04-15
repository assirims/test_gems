class EnrollmentMailer < ApplicationMailer
  # rails g mailer EnrollmentMailer

  def new_enrollment(enrollment)
    @enrollment = enrollment
    @course = @enrollment.course
    # comment one of the below line to see the different templates
    mail(to: @enrollment.user.email, subject: "You have enrolled to: #{@course}")
    mail(to: @enrollment.course.user.email, subject: "You have a new student in: #{@course}")
  end

end
