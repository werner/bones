module Bones
  module Joins
    class Join
      property to_table : TableDef
      property from_table : TableDef
      property on : Column

      def initialize(@from_table = TableDef.new, @to_table = TableDef.new, @on = Column.new)
      end

      def to_sql_string : String
        "#{join_type_string} JOIN #{@to_table.to_sql_string} ON #{@on.to_sql_with_op_string}"
      end

      def join_type_string : String
        ""
      end
    end
  end
end
