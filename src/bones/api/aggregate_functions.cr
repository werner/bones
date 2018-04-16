module Bones
  module SQL
    module AggregateFunctions
      include Bones::AggregateFunctions

      def sum(column = Column.new) : AggregateFunction
        Sum.new(column)
      end

      def avg(column = Column.new) : AggregateFunction
        Avg.new(column)
      end

      def count(column = Column.new) : AggregateFunction
        Count.new(column)
      end
    end
  end
end
