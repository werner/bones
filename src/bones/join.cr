module Bones
  class Join
    property to_table : TableDef
    property from_table : TableDef
    property from_on : Column
    property to_on : Column

    def initialize(@from_table = TableDef.new, @to_table = TableDef.new, @from_on = Column.new, @to_on = Column.new)
    end

    def to_sql_string : String
      "INNER JOIN #{@to_table.to_sql_string} ON #{@from_table.to_sql_string}.#{@from_on.to_sql_string} = #{@to_table.to_sql_string}.#{@to_on.to_sql_string}"
    end
  end
end
