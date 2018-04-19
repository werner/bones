module Bones
  module LogicalOperators
    class LogicalOperator
      property operator : ComparisonOperators::Operator | AggregateFunctions::AggregateFunction | Nil

      def initialize(@operator = nil)
      end

      def to_sql_string : String
        ""
      end
    end
  end
end
