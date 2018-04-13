module Bones
  class Join
    property table : Bones::TableDef
    property from_on : Bones::Column
    property to_on : Bones::Column

    def initialize(@table = Bones::TableDef.new, @from_on = Bones::Column.new, @to_on = Bones::Column.new)
    end
  end
end
