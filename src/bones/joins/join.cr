module Bones
  module Joins
    class Join
      property to_table : Granite::ORM::Base
      property from_table : Granite::ORM::Base
      property on : ComparisonOperators::Operator | Nil

      def initialize(@from_table = Granite::ORM::Base.new, @to_table = Granite::ORM::Base.new, @on = nil)
      end

      def to_sql_string : String
        # from_table.fields
        "#{join_type_string} JOIN #{@to_table.to_sql_string} ON #{@on.to_sql_with_op_string}"
      end

      def join_type_string : String
        ""
      end
    end
  end
end
