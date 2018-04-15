module Bones
  module AggregateFunctions
    class Sum < AggregateFunction
      def to_sql_string : String
        "SUM(#{@column.to_sql_string})"
      end
    end
  end
end
