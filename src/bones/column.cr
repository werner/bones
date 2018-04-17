require "./comparison_operators/operator"
require "./comparison_operators/operator_methods"
require "./sorting_operators/operator"
require "./sorting_operators/sorting_operator_methods"
require "./logical_operators/operator"
require "./logical_operators/logical_operator_methods"

module Bones
  class Column
    include ComparisonOperators::OperatorMethods
    include SortingOperators::SortingOperatorMethods
    include LogicalOperators::LogicalOperatorMethods

    property name : String
    property table : String
    property default_value : Int32 | String | Char | Nil
    property operator : ComparisonOperators::Operator = ComparisonOperators::Operator.new
    property sorting_operator : SortingOperators::Operator = SortingOperators::Operator.new
    property logical_operators : Array(LogicalOperators::LogicalOperator) = [] of LogicalOperators::LogicalOperator

    def initialize(@table = "", @name = "", @default_value = nil)
    end

    def to_sql_string : String
      "#{@table}.#{@name}"
    end

    def to_sql_with_op_string : String
      "#{@table}.#{@name} #{@operator.to_sql_string}#{to_sql_with_log_op_string}"
    end

    def to_sql_with_sort_op_string : String
      "#{@table}.#{@name} #{@sorting_operator.to_sql_string}"
    end

    def to_sql_with_log_op_string : String
      @logical_operators.map do |logical_operator|
        " #{logical_operator.to_sql_string}"
      end.join("")
    end

    def to_type
      @default_value.class
    end
  end
end
