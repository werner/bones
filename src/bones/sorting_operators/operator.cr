module Bones
  module SortingOperators
    class Operator
      property column : Column::Definition::Column | Nil = nil

      def initialize(@column : Column::Definition::Column)
      end

      def to_sql_string : String
        ""
      end
    end
  end
end
