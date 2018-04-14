require "./join"

module Bones
  module Joins
    class RightJoin < Join
      def join_type_string : String
        "RIGHT"
      end
    end
  end
end
