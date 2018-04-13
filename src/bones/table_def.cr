module Bones
  class TableDef
    property columns : Array(Column) = [] of Column

    def to_sql_string : String
      self.class.name.downcase
    end
  end
end
