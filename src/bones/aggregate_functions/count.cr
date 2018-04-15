module Bones
  module AggregateFunctions
    class Count < AggregateFunction
      def to_sql_string : String
        "COUNT(#{@column.to_sql_string})"
      end
    end
  end
end
