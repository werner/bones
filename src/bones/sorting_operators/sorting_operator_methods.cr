module Bones
  module SortingOperators
    module SortingOperatorMethods
      def asc
        @sorting_operator = Asc.new
        self
      end

      def desc
        @sorting_operator = Desc.new
        self
      end
    end
  end
end
