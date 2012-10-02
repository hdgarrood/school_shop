module GarmentsHelper
  def render_size(size)
    other_units = Size.unit_values
    other_units.delete(size.unit)

    other_sizes = other_units.map { |u| size.convert_to(u) }

    title = "This is the same as:\n"
    title << other_sizes.join("\n")

    content_tag(:span, :class => 'size', :title => title) do
      size.to_s
    end
  end
end
