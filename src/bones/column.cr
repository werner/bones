require "./comparison_operators/operator"
require "./comparison_operators/operator_methods"
require "./sorting_operators/operator"
require "./sorting_operators/sorting_operator_methods"
require "./logical_operators/operator"
require "./logical_operators/logical_operator_methods"
require "./exceptions/one_column_property_exception"

module Bones
  class Column
    include ComparisonOperators::OperatorMethods
    include SortingOperators::SortingOperatorMethods
    include LogicalOperators::LogicalOperatorMethods

    @@columns_count = [] of Int32

    property table : TableDef
    property operator : ComparisonOperators::Operator = ComparisonOperators::Operator.new
    property sorting_operator : SortingOperators::Operator = SortingOperators::Operator.new
    property logical_operators : Array(LogicalOperators::LogicalOperator) = [] of LogicalOperators::LogicalOperator

    def initialize(@table = TableDef.new)
      if @@columns_count.size > 1
        raise Bones::Exceptions::OneColumnPropertyException.new
      end
    end

    macro column(name)
      @@columns_count << 1
      {% if name.type.stringify == "Int32" %}
        property {{name.var}} : {{name.type}} = 0
      {% elsif name.type.stringify == "String" %}
        property {{name.var}} : {{name.type}} = ""
      {% elsif name.type.stringify == "Char" %}
        property {{name.var}} : {{name.type}} = '\''
      {% end %}

      def column_to_string : String
        "#{@table.to_sql_string}.#{{{name.var.stringify}}}"
      end

      def column_with_op_to_string : String
        "#{@table.to_sql_string}.#{{{name.var.stringify}}} #{@operator.to_sql_string}#{column_with_log_op_to_string}"
      end

      def column_with_sort_op_to_string : String
        "#{@table.to_sql_string}.#{{{name.var.stringify}}} #{@sorting_operator.to_sql_string}"
      end

      def column_with_log_op_to_string : String
        @logical_operators.map do |logical_operator|
          " #{logical_operator.to_sql_string}"
        end.join("")
      end

      def column_to_type
        {{name.type}}
      end
    end

    def to_sql_string : String
      if self.responds_to?(:column_to_string)
        self.column_to_string
      else
        ""
      end
    end

    def to_sql_with_op_string : String
      if self.responds_to?(:column_with_op_to_string)
        self.column_with_op_to_string
      else
        ""
      end
    end

    def to_sql_with_sort_op_string : String
      if self.responds_to?(:column_with_sort_op_to_string)
        self.column_with_sort_op_to_string
      else
        ""
      end
    end

    def to_sql_with_log_op_string : String
      if self.responds_to?(:column_with_log_op_to_string)
        self.column_with_log_op_to_string
      else
        ""
      end
    end

    def to_type
      if self.responds_to?(:column_to_type)
        self.column_to_type
      else
        nil
      end
    end
  end
end
