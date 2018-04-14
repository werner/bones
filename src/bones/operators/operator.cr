module Bones
  module Operators
    module OperatorMethods
      property operator : Operator = Operator.new

      def eq(column : Column)
        @operator = Eq.new(self, column)
        self
      end
    end
  end
end
