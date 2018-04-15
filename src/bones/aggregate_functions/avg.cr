module Bones
  module AggregateFunctions
    class Avg < AggregateFunction
      def to_sql_string : String
        "AVG(#{@column.to_sql_string})"
      end
    end
  end
end
