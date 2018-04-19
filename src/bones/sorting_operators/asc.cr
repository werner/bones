require "./operator"

module Bones
  module SortingOperators
    class Asc < Operator
      def to_sql_string : String
        "ASC"
      end
    end
  end
end
