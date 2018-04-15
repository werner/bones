module Bones
  module LogicalOperators
    class And
      property column : Column

      def initialize(@column = Column.new)
      end

      def to_sql_string : String
        "AND #{@column.to_sql_with_op_string}"
      end
    end
  end
end
