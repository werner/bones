require "../comparison_operators/operator"
require "../comparison_operators/operator_methods"
require "../logical_operators/operator"
require "../logical_operators/logical_operator_methods"

module Bones
  module AggregateFunctions
    class AggregateFunction
      include ComparisonOperators::OperatorMethods
      include LogicalOperators::LogicalOperatorMethods

      property column : Column
      property operator : ComparisonOperators::Operator = ComparisonOperators::Operator.new
      property logical_operators : Array(LogicalOperators::LogicalOperator) = [] of LogicalOperators::LogicalOperator

      def initialize(@column : Column = Column.new)
      end

      def to_sql_string : String
        ""
      end

      def to_sql_with_op_string : String
        "#{to_sql_string} #{@operator.to_sql_string}#{to_sql_with_log_op_string}"
      end

      def to_sql_with_log_op_string : String
        @logical_operators.map do |logical_operator|
          " #{logical_operator.to_sql_string}"
        end.join("")
      end

      def to_type
        self.column.to_type
      end
    end
  end
end
