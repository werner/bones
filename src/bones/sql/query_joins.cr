module Bones
  module SQL
    module QueryJoins

      property join_tables : Array(Joins::Join) = [] of Joins::Join

      def inner_join(from_table = @from_table, to_table = TableDef.new, on = Column.new) : SQL
        @join_tables << Joins::InnerJoin.new(from_table, to_table, on)
        self
      end

      def left_join(from_table = @from_table, to_table = TableDef.new, on = Column.new) : SQL
        @join_tables << Joins::LeftJoin.new(from_table, to_table, on)
        self
      end

      def right_join(from_table = @from_table, to_table = TableDef.new, on = Column.new) : SQL
        @join_tables << Joins::RightJoin.new(from_table, to_table, on)
        self
      end

      def outer_join(from_table = @from_table, to_table = TableDef.new, on = Column.new) : SQL
        @join_tables << Joins::OuterJoin.new(from_table, to_table, on)
        self
      end
    end
  end
end
