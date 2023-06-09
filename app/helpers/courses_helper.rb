module CoursesHelper
  def enrollments_button(course)
    if current_user
      #logic to buy course
      if course.user == current_user
        # this is the owner of the course and cannot buy it but can view analytics
        link_to "You created this course (" + number_to_currency(course.price)+")", course_path(course), class: "btn btn-primary"
      elsif course.enrollments.where(user: current_user).any?
        # user has already bought the course and can view lessons
        npp = number_to_percentage(course.progress(current_user), precision: 0)
        link_to course_path(course) do
          # "You bought this course. View lessons" +
          if npp.to_i == 0
            "You bought this course. Start learning"
          else
            npp.to_s + " completed"
          end
        end
      elsif course.price > 0
        # user can buy the course
        link_to "buy it " + number_to_currency(course.price), new_course_enrollment_path(course), class: "btn btn-success"
      else
        # course is free
        link_to "Free", new_course_enrollment_path(course), class: "btn btn-success"
      end
        # logic to buy course
    else
      # link_to "Check price", course_path(course), class: "btn btn-success"
      link_to "Join and check price", new_course_enrollment_path(course), class: "btn btn-success"
    end
  end

  def review_button(course)
    user_course = course.enrollments.where(user: current_user)
    if current_user && user_course.any?
      review_button_message(course, user_course)
    else
      return nil
    end
  end

  def review_button_message(course, user_course)
    if user_course.pending_review.any?
      link_to 'Add a review', edit_enrollment_path(user_course.first), class: "btn btn-primary"
    else
      link_to 'Thanks for reviewing!', enrollment_path(user_course.first), class: "btn btn-primary"
    end
  end

  def certificate_button(course)
    user_course = course.enrollments.where(user: current_user)
    if current_user && user_course.any?
      if course.progress(current_user) == 100
        link_to certificate_enrollment_path(user_course.first, format: :pdf) do
          "<i class='text-danger fa fa-file-pdf'></i>".html_safe + ' ' \
            'Certificate of Completion'
        end
      else
        'Certificate available after completion'
      end
    end
  end

end
