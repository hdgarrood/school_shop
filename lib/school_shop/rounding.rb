module SchoolShop
  module Rounding
    def round_to_nearest_quarter(flt)
      four_times = (4 * flt).round

      int_bit = four_times / 4
      remainder = four_times % 4

      case remainder
      when 0
        fraction_bit = ""
      when 1
        fraction_bit = ".25"
      when 2
        fraction_bit = ".5"
      when 3
        fraction_bit = ".75"
      end

      "#{int_bit}#{fraction_bit}"
    end

    def round_to_nearest_half(flt)
      two_times = (2 * flt).round

      int_bit = two_times / 2
      remainder = two_times % 2

      case remainder
      when 0
        fraction_bit = ""
      when 1
        fraction_bit = ".5"
      end

      "#{int_bit}#{fraction_bit}"
    end

    def round(flt)
      flt.round.to_s
    end
  end
end
