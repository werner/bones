module Bones
  module Exceptions
    class GroupByMissingColumnException < Exception
      def initialize(column : Column)
        super("ERROR:  column #{column.to_sql_string} must appear in the GROUP BY clause or be used in an aggregate function")
      end
    end
  end
end
