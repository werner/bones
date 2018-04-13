module Bones
  class Column

    macro column(name)
      {% if name.type.stringify == "Int32" %}
        property {{name.var}} : {{name.type}} = 0
      {% elsif name.type.stringify == "String" %}
        property {{name.var}} : {{name.type}} = ""
      {% elsif name.type.stringify == "Char" %}
        property {{name.var}} : {{name.type}} = '\''
      {% end %}
    end

    def to_sql_string
      {% for var in @type.instance_vars %}
        {{var.stringify}}
      {% end %}
    end
  end
end
