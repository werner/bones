module Bones
  module SQL
    class SQL

      include LogicalOperators

      property select_fields : Array(Select) = [] of Select
      property from_table : TableDef = TableDef.new
      property join_tables : Array(Joins::Join) = [] of Joins::Join
      property where : Array(Where) = [] of Where
      property limit : Limit | Nil = nil

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

      def right_join(from_table = @from_table, to_table = TableDef.new, on = Column.new) : SQL
        @join_tables << Joins::RightJoin.new(from_table, to_table, on)
        self
      end

      def outer_join(from_table = @from_table, to_table = TableDef.new, on = Column.new) : SQL
        @join_tables << Joins::OuterJoin.new(from_table, to_table, on)
        self
      end

      def where(column = Column.new) : SQL
        @where << Where.new(column)
        self
      end

      def limit(value : Int32) : SQL
        @limit = Limit.new(value)
        self
      end

      def to_sql_string : String
        sql_string = ""
        sql_string = "SELECT #{@select_fields.map {|item| item.to_sql_string }.join(", ")}" unless @select_fields.empty?
        sql_string = "#{sql_string} FROM #{@from_table.to_sql_string}"
        sql_string = "#{sql_string} #{@join_tables.map {|join_table| join_table.to_sql_string }.join(" ")}" unless @join_tables.empty?
        sql_string = "#{sql_string} #{@where.map {|where| where.to_sql_string }.join(" ")}" unless @where.empty?
        sql_string = "#{sql_string} #{@logical_operators.map {|logical_operators| logical_operators.to_sql_string }.join(" ")}" unless @logical_operators.empty?
        limit = @limit
        sql_string = "#{sql_string} #{limit.to_sql_string}" unless limit.nil?
        sql_string
      end
    end
  end
end
