module Bones
  class SQL
    property select_fields : Array(Select)
    property from_table : TableDef
    property inner_join_tables : Array(Join)

    def initialize
      @select_fields = [] of Select
      @from_table = TableDef.new
      @inner_join_tables = [] of Join
    end

    def select(_select : Select) : SQL
      @select_fields << _select
      self
    end

    def from(table : TableDef): SQL
      @from_table = table
      self
    end

    def inner_join(join : Join): SQL
      join.table_from = @from_table
      @inner_join_tables << join
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
