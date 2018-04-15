module Bones
  class Where
    property column : Column

    def initialize(@column = Column.new)
    end

    def to_sql_string : String
      "WHERE #{@column.to_sql_with_op_string}"
    end
  end
end
