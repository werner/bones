require "./join"

module Bones
  module Joins
    class InnerJoin < Join
      def join_type_string : String
        "INNER"
      end
    end
  end
end
