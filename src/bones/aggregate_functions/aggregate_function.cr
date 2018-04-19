module Bones
  module AggregateFunctions
    class AggregateFunction
      include Column::Definition

      property column : Column = nil

      def initialize(@column : Column)
      end

      def to_sql_string : String
        ""
      end

      def to_type
        self.column.class
      end
    end
  end
end
