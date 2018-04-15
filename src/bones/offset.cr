module Bones
  class Offset
    property value : Int32

    def initialize(@value = 0)
    end

    def to_sql_string : String
      "OFFSET #{value}"
    end
  end
end
