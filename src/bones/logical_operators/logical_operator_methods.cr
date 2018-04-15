module Bones
  module LogicalOperators
    module LogicalOperatorMethods
      def and(column : Column | AggregateFunctions::AggregateFunction) : Column | AggregateFunctions::AggregateFunction
        @logical_operators << And.new(column)
        self
      end

      def or(column : Column | AggregateFunctions::AggregateFunction) : Column | AggregateFunctions::AggregateFunction
        @logical_operators << Or.new(column)
        self
      end
    end
  end
end
