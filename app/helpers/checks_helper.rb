module ChecksHelper
  def is_checked(activity, checked, checker)
    Check.find_by(activity: activity, checked: checked, checker:checker)
  end

  def mutual_check(activity, checked, checker)
    is_checked && Check.find_by(activity: activity, checked: checker, checker:checked)
  end
end
