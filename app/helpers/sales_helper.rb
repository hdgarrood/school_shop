require 'csv'

module SalesHelper 
  def csv_attrs(garment)
    {
      :id => garment.id,
      :type => garment.garment_type,
      :price => number_to_currency(garment.price),
      :received_on => l(garment.created_at.to_date, :format => :long),
      :sold_on => l(garment.sold_at.to_date, :format => :long)
    }
  end

  def sales_to_csv(sold_garments)
    str = csv_attrs(sold_garments.first).
      keys.
      map(&:to_s).
      map(&:humanize).
      to_csv
    str << CSV.generate do |csv|
      sold_garments.each do |sg|
        csv << csv_attrs(sg).values
      end
    end
    str.html_safe
  end
end
