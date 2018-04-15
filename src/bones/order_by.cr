module Bones
  class OrderBy
    property columns : Array(OrderByColumn)

    def initialize(@columns = [] of OrderByColumn)
    end

    def to_sql_string : String
      "ORDER BY #{@columns.map(&.to_sql_string).join(", ")}"
    end
  end
end
