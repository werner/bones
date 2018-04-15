module Bones
  class Select
    property columns : Array(SelectColumn)

    def initialize(@columns = [] of SelectColumn)
    end

    def to_sql_string : String
      @columns.map(&.to_sql_string).join(", ")
    end
  end
end
