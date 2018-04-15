module Bones
  module ComparisonOperators
    class Operator
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
