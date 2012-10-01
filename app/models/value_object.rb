# Basic class for value objects.
# sending has_fields as the class (not within a method) will do the
# following:
#
#   Create an attr_reader for each field
#
#   Allow the field to be set in the constructor, either positionally
#   or in a hash
#
#   Allow #== to work, by comparing each field with the corresponding
#   field of the other object
#
#   Allow #empty? to work, by checking that each field is nil, and
#   returning true if so, or false otherwise.
#
# Note that it is possible to call has_fields twice; the fields will
# simply be added on to the end of the existing ones.
class ValueObject
  class << self
    attr_reader :fields

    def has_fields(*fields)
      @fields ||= []
      fields.each do |f| 
        attr_reader f
        @fields << f
      end
    end
  end

  def fields
    self.class.fields
  end

  def initialize(*args)
    if args.length == 1 && args[0].is_a?(Hash)
      fields.each { |f| instance_variable_set "@#{f}", args[0][f] }
    else
      fields.each_with_index { |f, idx| instance_variable_set "@#{f}", args[idx] }
    end
  end

  def ==(other)
    fields.all? { |f| send(f) == other.send(f) }
  end

  def empty?
    fields.all? { |f| send(f).nil? }
  end
end
