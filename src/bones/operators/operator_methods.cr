module Bones
  module Operators
    module OperatorMethods

      def eq(column : Column)
        @operator = Eq.new(self, column)
        self
      end

      def eq(value : String | Char | Int32 | Int64 | Float32 | Float64 | Nil)
        @operator = Eq.new(self, value)
        self
      end
    end
  end
end
