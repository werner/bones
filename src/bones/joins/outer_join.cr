require "./join"

module Bones
  module Joins
    class OuterJoin < Join
      def join_type_string : String
        "OUTER"
      end
    end
  end
end
