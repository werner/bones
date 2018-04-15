require "./base"
require "./operator"

module Bones
  module LogicalOperators
    class And < LogicalOperator
      include Base

      def to_sql_string : String
        "AND #{@column.to_sql_with_op_string}"
      end
    end
  end
end
