module Bones
  class Where
    property to_table : TableDef
    property from_table : TableDef
    property column : Column

    def initialize(@from_table = TableDef.new, @to_table = TableDef.new, @column = Column.new)
    end

    def to_sql_string : String
      "WHERE #{@column.to_sql_with_op_string}"
    end
  end
end

