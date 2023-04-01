module UsersHelper
  def style_role(role)
    case role
    when 'student'
      'success'
    when 'teacher'
      'primary'
    when 'admin'
      'danger'
    end
  end
end
