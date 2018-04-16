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

      # Starts the query builder, it's the select clause with a series of columns arguments.
      #
      # ```
      # class MyColumn < Bones::Column
      #   column name : String
      # end
      #
      # class MyAnotherColumn < Bones::Column
      #   column name : Int32
      # end
      #
      # class MyTable < Bones::TableDef
      # end
      #
      # my_table = MyTable.new
      # my_column = MyColumn.new(my_table)
      #
      # sql = Bones::SQL::SQL.new
      # sql.select(my_column, sql.sum(my_another_column))
      # ``` 
      def select(*columns) : SQL
        @select_fields = Select.new(columns.map { |column| SelectColumn.new(column) }.to_a)
        self
      end

      # From SQL clause, with a TableDef argument.
      #
      # ```
      # sql.select(my_column, sql.sum(my_another_column)).from(my_table)
      # ```
      def from(table : TableDef) : SQL
        @from_table = table
        self
      end

      # Where SQL clause, allow only one column argument, the rest can be concatenated.
      #
      # ```
      # sql.select(my_column).from(my_table).where(my_column.eq("Peter").and(my_another_column.gt(10)))
      # ```
      def where(column = Column.new) : SQL
        @where = Where.new(column)
        self
      end

      # Having SQL clause, allow only one aggregate function argument, the rest can be concatenated.
      #
      # ```
      # sql.select(my_column).from(my_table).having(sql.count(my_column).gt(1).and(sql.avg(my_another_column).gt(10)))
      # ```
      def having(aggregate_function = AggregateFunction.new) : SQL
        @having = Having.new(aggregate_function)
        self
      end

      # Group By SQL clause, you can add a series of columns.
      # It checks all columns in select clause are added here or in an aggregate function.
      #
      # ```
      # sql.select(my_column).from(my_table).group_by(my_column)
      # ```
      def group_by(*columns) : SQL
        group_by_columns = columns.map { |column| GroupByColumn.new(column) }.to_a
        check_group_by_columns(group_by_columns)
        @group_by = GroupBy.new(group_by_columns)
        self
      end

      # Order By SQL clause, you can add a series of columns.
      #
      # ```
      # sql.select(my_column).from(my_table).order_by(my_column.asc)
      # ```
      def order_by(*columns) : SQL
        @order_by = OrderBy.new(columns.map { |column| OrderByColumn.new(column) }.to_a)
        self
      end

      # Limit SQL clause, accept only Int32 values.
      #
      # ```
      # sql.select(my_column).from(my_table).limit(100)
      # ```
      def limit(value : Int32) : SQL
        @limit = Limit.new(value)
        self
      end

      # Offset SQL clause, accept only Int32 values.
      #
      # ```
      # sql.select(my_column).from(my_table).limit(100).offset(1)
      # ```
      def offset(value : Int32) : SQL
        @offset = Offset.new(value)
        self
      end

      # Returns the SQL query in a String.
      #
      # ```
      # sql.select(my_column).from(my_table).where(my_column.eq("Peter").and(my_another_column.gt(10))).to_sql_string
      # # => SELECT my_table.my_column FROM my_table WHERE my_table.my_column = 'Peter' AND my_table.my_another_column > 10
      # ```
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
