module Bones
  module SortingOperators
    module SortingOperatorMethods
      def asc : Column
        @sorting_operator = Asc.new
        self
      end

      def desc : Column
        @sorting_operator = Desc.new
        self
      end
    end
  end
end
