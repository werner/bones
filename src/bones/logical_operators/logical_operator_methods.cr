module Bones
  module LogicalOperators
    module LogicalOperatorMethods
      def and(operator : ComparisonOperators::Operator | AggregateFunctions::AggregateFunction)
        @logical_operators << And.new(operator)
        self
      end

      def or(operator : ComparisonOperators::Operator | AggregateFunctions::AggregateFunction)
        @logical_operators << Or.new(operator)
        self
      end
    end
  end
end
