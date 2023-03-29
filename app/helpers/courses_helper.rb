module CoursesHelper
  def enrollments_button(course)
    if current_user
      #logic to buy course
      if course.user == current_user
        # this is the owner of the course and cannot buy it but can view analytics
        link_to "You created this course. View analytics", course_path(course), class: "btn btn-primary"
      elsif course.enrollments.where(user: current_user).any?
        # user has already bought the course and can view lessons
        link_to "You bought this course. View lessons", course_path(course), class: "btn btn-primary"
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
    if current_user
      if user_course.any?
        if user_course.pending_review.any?
          link_to 'Add a review', edit_enrollment_path(user_course.first), class: 'btn btn-secondary'
        else
          link_to 'Thanks for reviewing! Your Review', enrollment_path(user_course.first), class: 'btn btn-secondary'
        end
      end
    end
  end
end
