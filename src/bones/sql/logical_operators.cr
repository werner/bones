module Bones
  module SQL
    module LogicalOperators
      include Bones::LogicalOperators

      property and : Array(And) = [] of And

      def and(column = Column.new) : SQL
        @and << And.new(column)
        self
      end
    end
  end
end
