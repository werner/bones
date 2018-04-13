module Bones
  class TableDef
    def to_sql_string : String
      self.class.name.downcase
    end
  end
end
