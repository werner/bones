require "./operators/operator_methods"

module Bones
  class Column
    include Operators::OperatorMethods
    property table : TableDef

    def initialize(@table = TableDef.new)
    end

    macro column(name)
      {% if name.type.stringify == "Int32" %}
        property {{name.var}} : {{name.type}} = 0
      {% elsif name.type.stringify == "String" %}
        property {{name.var}} : {{name.type}} = ""
      {% elsif name.type.stringify == "Char" %}
        property {{name.var}} : {{name.type}} = '\''
      {% end %}

      def column_to_string : String
        return "#{@table.to_sql_string}.#{{{name.var.stringify}}}"
      end

      def column_with_op_to_string : String
        return "#{@table.to_sql_string}.#{{{name.var.stringify}}} #{@operator.to_sql_string}"
      end

      def column_to_type
        return {{name.type}}
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

    def to_type
      if self.responds_to?(:column_to_type)
        self.column_to_type
      else
        nil
      end
    end
  end
end
