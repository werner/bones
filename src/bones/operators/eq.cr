require "./operator"

module Bones
  module Operators
    class Eq < Operator
      property left_column : Column = Column.new
      property right_column : Column = Column.new
      property value : String | Char | Int32 | Int64 | Float32 | Float64 | Nil = nil

      def initialize(@left_column : Column, @right_column : Column)
        raise Exceptions::ColumnNotEqualTypeException.new(@left_column.to_sql_string, @right_column.to_sql_string) if @left_column.to_type != @right_column.to_type
      end

      def initialize(@left_column : Column, @value : String | Char | Int32 | Int64 | Float32 | Float64 | Nil)
        raise Exceptions::ColumnNotEqualValueTypeException.new(@left_column.to_sql_string, value) if @left_column.to_type != @value.class
      end

     def to_sql_string : String
       "= #{format_type(@value) || @right_column.to_sql_string}"
     end
    end
  end
end
