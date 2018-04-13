module Bones
  class Select
    property table : TableDef
    property columns : Array(SelectColumn)

    def initialize(@table = TableDef, @columns = [] of SelectColumn)
    end

    def to_sql_string : String
      @columns.map do |column| 
        "#{@table.to_sql_string}.#{column.to_sql_string}"
      end.join(", ")
    end
  end
end
