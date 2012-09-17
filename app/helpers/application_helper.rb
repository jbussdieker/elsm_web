module ApplicationHelper
  def generic_badge(msg)
    if msg.to_s.downcase == "running"
      content_tag(:i, msg, class: "badge badge-success")
    elsif msg.to_s.downcase == "changed"
      content_tag(:i, msg, class: "badge badge-warning")
    else
      content_tag(:i, msg, class: "badge")
    end
  end
end
