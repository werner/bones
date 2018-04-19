module Bones
  class Where
    property operator : ComparisonOperators::Operator | Nil

    def initialize(@operator = nil)
    end

    def to_sql_string : String
      "WHERE #{@operator.to_sql_with_op_string}"
    end
  end
end
