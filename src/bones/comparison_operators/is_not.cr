require "./operator"

module Bones
  module ComparisonOperators
    class IsNot < Operator
      def to_sql_string : String
        "IS NOT #{validates_value}"
      end
    end
  end
end
