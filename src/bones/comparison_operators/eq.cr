require "./operator"

module Bones
  module ComparisonOperators
    class Eq < Operator
      def to_sql_string : String
        "= #{validates_value}"
      end
    end
  end
end
