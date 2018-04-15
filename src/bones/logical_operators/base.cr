module Bones
  module LogicalOperators
    module Base
      property column : Column | AggregateFunctions::AggregateFunction

      def initialize(@column = Column.new)
      end
    end
  end
end
