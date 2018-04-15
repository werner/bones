module Bones
  class Limit
    property value : Int32

    def initialize(@value = 0)
    end

    def to_sql_string : String
      "LIMIT #{value}"
    end
  end
end

