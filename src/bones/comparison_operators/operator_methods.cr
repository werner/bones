module Bones
  module ComparisonOperators
    module OperatorMethods
      def eq(left_column : Column::Definition::Column, right_column : Column::Definition::Column)
        Eq.new(left_column, right_column)
      end

      def not_eq(left_column : Column::Definition::Column, right_column : Column::Definition::Column)
        NotEq.new(left_column, right_column)
      end

      def is(left_column : Column::Definition::Column, right_column : Column::Definition::Column)
        Is.new(left_column, right_column)
      end

      def is_null(column : Column::Definition::Column)
        Is.new(column, nil)
      end

      def is_not(left_column : Column::Definition::Column, right_column : Column::Definition::Column)
        IsNot.new(left_column, right_column)
      end

      def is_not_null(column : Column::Definition::Column)
        IsNot.new(column, nil)
      end

      def gt(left_column : Column::Definition::Column, right_column : Column::Definition::Column)
        Gt.new(left_column, right_column)
      end

      def lt(left_column : Column::Definition::Column, right_column : Column::Definition::Column)
        Lt.new(left_column, right_column)
      end

      def gt_eq(left_column : Column::Definition::Column, right_column : Column::Definition::Column)
        GtEq.new(left_column, right_column)
      end

      def lt_eq(left_column : Column::Definition::Column, right_column : Column::Definition::Column)
        LtEq.new(left_column, right_column)
      end
    end
  end
end
