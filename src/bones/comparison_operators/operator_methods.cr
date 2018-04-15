module Bones
  module ComparisonOperators
    module OperatorMethods
      def eq(column : Column)
        @operator = Eq.new(self, column)
        self
      end

      def eq(value : String | Char | Int32 | Int64 | Float32 | Float64 | Nil)
        @operator = Eq.new(self, value)
        self
      end

      def not_eq(column : Column)
        @operator = NotEq.new(self, column)
        self
      end

      def not_eq(value : String | Char | Int32 | Int64 | Float32 | Float64 | Nil)
        @operator = NotEq.new(self, value)
        self
      end

      def gt(column : Column)
        @operator = Gt.new(self, column)
        self
      end

      def gt(value : String | Char | Int32 | Int64 | Float32 | Float64 | Nil)
        @operator = Gt.new(self, value)
        self
      end

      def lt(column : Column)
        @operator = Lt.new(self, column)
        self
      end

      def lt(value : String | Char | Int32 | Int64 | Float32 | Float64 | Nil)
        @operator = Lt.new(self, value)
        self
      end

      def gt_eq(column : Column)
        @operator = GtEq.new(self, column)
        self
      end

      def gt_eq(value : String | Char | Int32 | Int64 | Float32 | Float64 | Nil)
        @operator = GtEq.new(self, value)
        self
      end

      def lt_eq(column : Column)
        @operator = LtEq.new(self, column)
        self
      end

      def lt_eq(value : String | Char | Int32 | Int64 | Float32 | Float64 | Nil)
        @operator = LtEq.new(self, value)
        self
      end
    end
  end
end
