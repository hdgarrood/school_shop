require 'csv'

module SalesHelper 
  def render_garment_id(garment, format)
    case format
    when :html
      link_to(garment.to_short_s, garment)
    when :csv
      garment.id
    end
  end

  # list of arrays, where the first element of each is the header, and the
  # second is the value
  def garment_attributes(garment, format = :html)
    [
      [t('garments.name'), 
        render_garment_id(garment, format)],
      [t('garment_types.short_name'),
        garment.garment_type],
      [t('price'),
        number_to_currency(garment.price)],
      [t('garments.created_at'),
        l(garment.created_at.to_date, :format => :long)],
      [t('garments.sold_at'),
        l(garment.sold_at.to_date, :format => :long)]
    ]
  end

  def sales_to_csv(sold_garments)
    str = garment_attributes(sold_garments.first, :csv).
      map(&:first).
      map(&:to_s).
      map(&:humanize).
      to_csv
    str << CSV.generate do |csv|
      sold_garments.find_each do |sg|
        csv << garment_attributes(sg, :csv).map(&:last)
      end
    end
    str.html_safe
  end
end
