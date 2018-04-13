module Bones
  class SQL
    property from_table : Bones::TableDef
    property inner_join_tables : Array(Bones::Join)

    def initialize
      @from_table = Bones::TableDef.new
      @inner_join_tables = [] of Bones::Join
    end

    def _select(*query)
      query
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
