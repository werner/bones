module Bones
  module Exceptions
    class ColumnNotEqualTypeException < Exception
      property first_column : String
      property second_column : String

      def initialize(@first_column = "", @second_column = "")
        super("#{@first_column} and #{@second_column} are not of the same type")
      end
    end
  end
end
