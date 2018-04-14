require "./join"

module Bones
  module Joins
    class LeftJoin < Join
      def join_type_string : String
        "LEFT"
      end
    end
  end
end
