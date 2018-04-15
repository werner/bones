module Bones
  module SQL
    module LogicalOperators
      include Bones::LogicalOperators

      property logical_operators : Array(LogicalOperator) = [] of LogicalOperator

      def and(column = Column.new) : SQL
        @logical_operators << And.new(column)
        self
      end

      def or(column = Column.new) : SQL
        @logical_operators << Or.new(column)
        self
      end
    end
  end
end
