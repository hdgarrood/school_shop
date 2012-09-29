class SizeConverter
  class << self
    YEARS = 0
    HEIGHT_CM = 1
    CHEST_CM = 2
    WAIST_CM = 3
    COLLAR_CM = 4

    def cm_to_inches(cm)
      0.39370087 * cm
    end

    def inches_to_cm(inches)
      2.54 * inches
    end
  end
end
