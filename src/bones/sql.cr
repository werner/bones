module Bones
  class SQL
    property select_fields : Array(Select)
    property from_table : TableDef
    property inner_join_tables : Array(Join)
    property where : Array(Where)

    def initialize
      @select_fields = [] of Select
      @from_table = TableDef.new
      @inner_join_tables = [] of Join
      @where = [] of Where
    end

    def select(_select : Select) : SQL
      @select_fields << _select
      self
    end

    def from(table : TableDef): SQL
      @from_table = table
      self
    end

    def inner_join(from_table = @from_table, to_table = TableDef.new, from_on = Column.new, to_on = Column.new): SQL
      @inner_join_tables << Bones::Join.new(from_table, to_table, from_on, to_on)
      self
    end

    def where(from_table = @from_table, to_table = TableDef.new, column = Column.new)
      @where << Bones::Where.new(from_table, to_table, column)
      self
    end

    def to_sql_string : String
      sql_string = ""
      sql_string = "SELECT #{@select_fields.map {|item| item.to_sql_string }.join(", ")}" unless @select_fields.empty?
      sql_string = "#{sql_string} FROM #{@from_table.to_sql_string}"
      sql_string = "#{sql_string} #{@inner_join_tables.map {|join_table| join_table.to_sql_string }.join(" ")}" unless @inner_join_tables.empty?
      sql_string
    end
  end
end
