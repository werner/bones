module Bones
  class GroupBy
    property columns : Array(GroupByColumn)

    def initialize(@columns = [] of GroupByColumn)
    end

    def to_sql_string : String
      "GROUP BY #{@columns.map(&.to_sql_string).join(", ")}"
    end
  end
end
