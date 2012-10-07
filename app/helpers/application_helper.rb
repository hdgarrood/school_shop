module ApplicationHelper
  def render_datetime(datetime)
    content_tag(:time,
                :datetime => datetime.xmlschema,
                :class => "label label-info",
                :title => l(datetime.localtime, :format => :long)) do
      if datetime.past?
        time_ago_in_words(datetime)
      else
        distance_time_in_words(datetime)
      end
    end
  end
end
