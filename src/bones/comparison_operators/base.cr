module Bones
  module ComparisonOperators
    module Base
      property left_column : Column = Column.new
      property right_column : Column | Nil = nil
      property value : String | Char | Int32 | Int64 | Float32 | Float64 | Nil = nil

      def initialize(@left_column : Column, @right_column : Column)
        right_colum = @right_column
        unless right_column.nil?
          raise Exceptions::ColumnNotEqualTypeException.new(@left_column.to_sql_string, right_column.to_sql_string) if @left_column.to_type != right_column.to_type
        end
      end

      def initialize(@left_column : Column, @value : String | Char | Int32 | Int64 | Float32 | Float64 | Nil)
        unless self.is_a?(IsNot) && @value.nil?
          raise Exceptions::ColumnNotEqualValueTypeException.new(@left_column.to_sql_string, value) if @left_column.to_type != @value.class
        end
      end

      def validates_value : Column | String | Nil
        right_column = @right_column
        if right_column.nil?
          format_type(@value)
        else
          right_column.to_sql_string
        end
      end
    end
  end
end
