require "../comparison_operators/operator"
require "../comparison_operators/operator_methods"

module Bones
  module AggregateFunctions
    class AggregateFunction
      include ComparisonOperators::OperatorMethods

      property column : Column
      property operator : ComparisonOperators::Operator = ComparisonOperators::Operator.new

      def initialize(@column : Column = Column.new)
      end

      def to_sql_string : String
        ""
      end

      def to_sql_with_op_string : String
        "#{to_sql_string} #{@operator.to_sql_string}"
      end

      def to_type
        self.column.to_type
      end
    end
  end
end
