module Bones
  module AggregateFunctions
    class AggregateFunction
      property column : Column

      def initialize(@column : Column = Column.new)
      end

      def to_sql_string : String
        ""
      end
    end
  end
end
