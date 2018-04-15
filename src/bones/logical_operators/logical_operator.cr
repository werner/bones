module Bones
  module LogicalOperators
    class LogicalOperator
      property column : Column

      def initialize(@column = Column.new)
      end

      def to_sql_string : String
        ""
      end
    end
  end
end
