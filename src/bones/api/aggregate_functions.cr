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

      def count_all(table : TableDef | Nil = nil) : AggregateFunction
        if table.nil?
          Count.new("*")
        else
          Count.new("#{table.to_sql_string}.*")
        end
      end
    end
  end
end
