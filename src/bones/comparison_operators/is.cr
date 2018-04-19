require "./operator"

module Bones
  module ComparisonOperators
    class Is < Operator
      def to_sql_string : String
        "IS #{validates_value}"
      end
    end
  end
end
