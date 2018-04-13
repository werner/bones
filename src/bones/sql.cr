module Bones
  class SQL
    property select_fields : Array(Bones::Column)
    property from_table : Bones::TableDef
    property inner_join_tables : Array(Bones::Join)

    def initialize
      @select_fields = [] of Bones::Column
      @from_table = Bones::TableDef.new
      @inner_join_tables = [] of Bones::Join
    end

    def select(*columns)
      @select_fields = columns
    end

    def from(table : TableDef): SQL
      @from_table = table
      self
    end

    def inner_join(join : Join): SQL
      @inner_join_tables << join
      self
    end
  end
end
