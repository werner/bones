require "./operator"

module Bones
  module LogicalOperators
    class Or < LogicalOperator
      def to_sql_string : String
        "OR #{@column.to_sql_with_op_string}"
      end
    end
  end
end

