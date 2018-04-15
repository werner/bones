require "./operator"

module Bones
  module ComparisonOperators
    class LtEq < Operator
      include Base

      def to_sql_string : String
        right_side = if @value.nil?
                       @right_column.to_sql_string
                     else
                       format_type(@value)
                     end
        "<= #{right_side}"
      end
    end
  end
end

