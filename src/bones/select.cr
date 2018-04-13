module Bones
  class Select
    property table : TableDef
    property columns : Array(SelectColumn)

    def initialize(@table = TableDef, @columns = [] of SelectColumn)
      @columns.each do |column|
        column_to_find = column.column.to_sql_string
        next if column_to_find.nil?
        unless @table.columns.any? { |_column| _column.to_sql_string ==  column_to_find }
          raise Exceptions::NoColumnException.new(column_to_find, @table.to_sql_string)
        end
      end
    end

    def to_sql_string : String
      @columns.map do |column| 
        "#{@table.to_sql_string}.#{column.to_sql_string}"
      end.join(", ")
    end
  end
end
