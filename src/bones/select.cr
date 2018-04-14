module Bones
  class Select
    property table : TableDef
    property columns : Array(SelectColumn)

    def initialize(@table = TableDef, @columns = [] of SelectColumn)
    end

    def to_sql_string : String
      @columns.map(&.to_sql_string).join(", ")
    end
  end
end
