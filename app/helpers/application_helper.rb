module ApplicationHelper

  def page_context=(ctx)
    @page_context = ctx
  end

  def page_context
    @page_context
  end

  # Taken from - http://www.emersonlackey.com/article/rails3-error-messages-for-replacement
  def errors_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class='msg error #{object.class.name.humanize.downcase}Errors'>\n"
      if message.blank?
        if object.new_record?
          html << "\t\t<h5>There was a problem creating the #{object.class.name.humanize.downcase}</h5>\n"
        else
          html << "\t\t<h5>There was a problem updating the #{object.class.name.humanize.downcase}</h5>\n"
        end
      else
        html << "<h5>#{message}</h5>"
      end
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    html
  end

  def page_title(title)
    @page_title = title
  end
end
