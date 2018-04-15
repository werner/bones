module Bones
  class SQL
    property select_fields : Array(Select)
    property from_table : TableDef
    property join_tables : Array(Joins::Join)
    property where : Array(Where)

    def initialize
      @select_fields = [] of Select
      @from_table = TableDef.new
      @join_tables = [] of Joins::Join
      @where = [] of Where
    end

    def select(*columns) : SQL
      @select_fields << Select.new(columns.map { |column| SelectColumn.new(column) }.to_a)
      self
    end

    def from(table : TableDef) : SQL
      @from_table = table
      self
    end

    def inner_join(from_table = @from_table, to_table = TableDef.new, on = Column.new) : SQL
      @join_tables << Joins::InnerJoin.new(from_table, to_table, on)
      self
    end

    def left_join(from_table = @from_table, to_table = TableDef.new, on = Column.new) : SQL
      @join_tables << Joins::LeftJoin.new(from_table, to_table, on)
      self
    end

    def where(column = Column.new) : SQL
      @where << Where.new(column)
      self
    end

    def to_sql_string : String
      sql_string = ""
      sql_string = "SELECT #{@select_fields.map {|item| item.to_sql_string }.join(", ")}" unless @select_fields.empty?
      sql_string = "#{sql_string} FROM #{@from_table.to_sql_string}"
      sql_string = "#{sql_string} #{@join_tables.map {|join_table| join_table.to_sql_string }.join(" ")}" unless @join_tables.empty?
      sql_string = "#{sql_string} #{@where.map {|where| where.to_sql_string }.join(" ")}" unless @where.empty?
      sql_string
    end
  end
end
