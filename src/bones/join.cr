module Bones
  class Join
    property table : TableDef
    property table_from : TableDef
    property from_on : Column
    property to_on : Column

    def initialize(@table = TableDef.new, @from_on = Column.new, @to_on = Column.new)
      raise Exceptions::ColumnNotEqualTypeException.new(@from_on.to_sql_string, @to_on.to_sql_string) if @from_on.to_type != @to_on.to_type
      @table_from = TableDef.new
    end

    def to_sql_string : String
      "INNER JOIN #{@table.to_sql_string} ON #{@table_from.to_sql_string}.#{@from_on.to_sql_string} = #{@table.to_sql_string}.#{@to_on.to_sql_string}"
    end
  end
end
