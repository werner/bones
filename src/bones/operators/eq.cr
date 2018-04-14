module Bones
  module Operators
    class Eq < Operator
      def initialize(@left_column : Column, @right_column : Column)
        raise Exceptions::ColumnNotEqualTypeException.new(@left_column.to_sql_string, @right_column.to_sql_string) if @left_column.to_type != @right_column.to_type
      end
    end
  end
end
