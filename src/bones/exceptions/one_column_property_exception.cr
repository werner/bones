module Bones
  module Exceptions
    class OneColumnPropertyException < Exception
      def initialize
        super("Only one column property per Column Type")
      end
    end
  end
end
