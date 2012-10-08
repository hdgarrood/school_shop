class Search
  attr_reader :redirect_id, :results_list, :result

  def initialize(string)
    run_search!(string)
  end

  private
  def run_search!(search_string)
    # first check to see if the user entered a garment ID
    if (garment_id = search_string.to_i) > 0 && Garment.exists?(garment_id)
      @redirect_id = garment_id
      @result = :redirect_to_garment
    end
  end
end
