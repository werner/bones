module Bones
  module SortingOperators
    module SortingOperatorMethods
      def asc(column : Column::Definition::Column )
        @sorting_operator = Asc.new(column)
        self
      end

      def desc(column : Column::Definition::Column )
        @sorting_operator = Desc.new(column)
        self
      end
    end
  end
end
