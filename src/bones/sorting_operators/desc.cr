module Bones
  module SortingOperators
    class Desc < Operator
      def to_sql_string : String
        "DESC"
      end
    end
  end
end
