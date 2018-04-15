module Bones
  module SQL
    class SQL

      include LogicalOperators

      property select_fields : Select = Select.new
      property from_table : TableDef = TableDef.new
      property join_tables : Array(Joins::Join) = [] of Joins::Join
      property where : Array(Where) = [] of Where
      property group_by : GroupBy = GroupBy.new
      property order_by : OrderBy = OrderBy.new
      property limit : Limit | Nil = nil
      property offset : Offset | Nil = nil

      def select(*columns) : SQL
        @select_fields = Select.new(columns.map { |column| SelectColumn.new(column) }.to_a)
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

      def group_by(*columns) : SQL
        @group_by = GroupBy.new(columns.map { |column| GroupByColumn.new(column) }.to_a)
        self
      end

      def order_by(*columns) : SQL
        @order_by = OrderBy.new(columns.map { |column| OrderByColumn.new(column) }.to_a)
        self
      end

      def limit(value : Int32) : SQL
        @limit = Limit.new(value)
        self
      end

      def offset(value : Int32) : SQL
        @offset = Offset.new(value)
        self
      end

      def to_sql_string : String
        sql_string = ""
        sql_string = "#{@select_fields.to_sql_string}" unless @select_fields.columns.empty?
        sql_string = "#{sql_string} FROM #{@from_table.to_sql_string}"
        sql_string = "#{sql_string} #{@join_tables.map {|join_table| join_table.to_sql_string }.join(" ")}" unless @join_tables.empty?
        sql_string = "#{sql_string} #{@where.map {|where| where.to_sql_string }.join(" ")}" unless @where.empty?
        sql_string = "#{sql_string} #{@logical_operators.map {|logical_operators| logical_operators.to_sql_string }.join(" ")}" unless @logical_operators.empty?
        sql_string = "#{sql_string} #{@group_by.to_sql_string}" unless @group_by.columns.empty?
        sql_string = "#{sql_string} #{@order_by.to_sql_string}" unless @order_by.columns.empty?
        limit = @limit
        sql_string = "#{sql_string} #{limit.to_sql_string}" unless limit.nil?
        offset = @offset
        sql_string = "#{sql_string} #{offset.to_sql_string}" unless offset.nil?
        sql_string
      end
    end
  end
end
