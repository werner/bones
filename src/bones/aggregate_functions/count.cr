module Bones
  module AggregateFunctions
    class Count < AggregateFunction

      property all : String | Nil = nil

      def initialize(value : String | Column)
        if value.is_a?(Column)
          @column = value
        elsif value.is_a?(String)
          @all = value
        end
      end

      def to_sql_string : String
        if @all.nil?
          "COUNT(#{@column.to_sql_string})"
        else
          "COUNT(#{@all})"
        end
      end
    end
  end
end
