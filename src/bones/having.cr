module Bones
  class Having
    property aggregate_function : AggregateFunctions::AggregateFunction

    def initialize(@aggregate_function = AggregateFunctions::AggregateFunction.new)
    end

    def to_sql_string : String
      "HAVING #{@aggregate_function.to_sql_with_op_string}"
    end
  end
end
