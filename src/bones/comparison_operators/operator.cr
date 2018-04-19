module Bones
  module ComparisonOperators
    class Operator

      property left_column : Column::Definition::Column | AggregateFunctions::AggregateFunction
      property right_column : Column::Definition::Column | Nil

      def initialize(@left_column : Column::Definition::Column | AggregateFunctions::AggregateFunction, @right_column : Column::Definition::Column)
        right_colum = @right_column
        unless right_column.nil?
          raise Exceptions::ColumnNotEqualTypeException.new(@left_column.to_s, right_column.to_s) if @left_column.class != right_column.class
        end
      end

      def validates_value : Column | Nil
        @right_column
      end

      def format_type(value : String | Char) : String
        "'#{value.to_s}'"
      end

      def format_type(value : Int32 | Int64 | Float32 | Float64) : String
        value.to_s
      end

      def format_type(value : Nil) : String
        "NULL"
      end

      def to_sql_string : String
        ""
      end
    end
  end
end
