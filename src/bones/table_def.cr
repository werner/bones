module Bones
  class TableDef
    property name : String

    def initialize(@name = "")
    end

    def to_sql_string : String
      @name.downcase
    end
  end
end
