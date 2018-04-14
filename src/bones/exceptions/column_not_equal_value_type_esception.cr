module Bones
  module Exceptions
    class ColumnNotEqualValueTypeException < Exception
      property first_column : String

      def initialize(@first_column = "", value = "")
        super("#{@first_column} and #{value} are not of the same type")
      end
    end
  end
end

