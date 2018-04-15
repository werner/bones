require "./operator"

module Bones
  module ComparisonOperators
    class GtEq < Operator
      include Base

      def to_sql_string : String
        ">= #{validates_value}"
      end
    end
  end
end
