module Bones
  module SQL
    class SQL

      include LogicalOperators
      include AggregateFunctions
      include QueryJoins

      property select_fields : Select = Select.new
      property from_table : TableDef = TableDef.new
      property where : Where | Nil = nil
      property group_by : GroupBy = GroupBy.new
      property having : Having | Nil = nil
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

      def where(column = Column.new) : SQL
        @where = Where.new(column)
        self
      end

      def having(aggregate_function = AggregateFunction.new) : SQL
        @having = Having.new(aggregate_function)
        self
      end

      def group_by(*columns) : SQL
        group_by_columns = columns.map { |column| GroupByColumn.new(column) }.to_a
        check_group_by_columns(group_by_columns)
        @group_by = GroupBy.new(group_by_columns)
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
        where = @where
        sql_string = "#{sql_string} #{where.to_sql_string}" unless where.nil?
        sql_string = "#{sql_string} #{@group_by.to_sql_string}" unless @group_by.columns.empty?
        having = @having
        sql_string = "#{sql_string} #{having.to_sql_string}" unless having.nil?
        sql_string = "#{sql_string} #{@order_by.to_sql_string}" unless @order_by.columns.empty?
        limit = @limit
        sql_string = "#{sql_string} #{limit.to_sql_string}" unless limit.nil?
        offset = @offset
        sql_string = "#{sql_string} #{offset.to_sql_string}" unless offset.nil?
        sql_string
      end

      private def check_group_by_columns(group_by_columns : Array(GroupByColumn))
        group_by_columns_columns = group_by_columns.map(&.column)
        select_columns = @select_fields.columns.reject { |column| column.column.is_a?(AggregateFunction) }.map(&.column)
        select_columns.each do |column|
          if column.is_a?(Column)
            raise Exceptions::GroupByMissingColumnException.new(column) unless group_by_columns.map(&.column).find{ |group_column| group_column.class == column.class }
          end
        end
      end
    end
  end
end
