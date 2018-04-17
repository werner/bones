module Bones
  class TableDef
    @@columns = [] of Column
    @@name : String = ""

    macro table_name(name)
      @@name : String = {{name.stringify}}
    end

    macro column(name)
      {% if name.type.stringify == "Int32" %}
        property {{name.var}} : Bones::Column = Bones::Column.new(@@name, {{name.var.stringify}}, 0)
      {% elsif name.type.stringify == "String" %}
        property {{name.var}} : Bones::Column = Bones::Column.new(@@name, {{name.var.stringify}}, "")
      {% elsif name.type.stringify == "Char" %}
        property {{name.var}} : Bones::Column = Bones::Column.new(@@name, {{name.var.stringify}}, '\'')
      {% end %}
    end

    macro has_many(name)
      property {{name.id}} : Array({{name.id.camelcase}}) = [] of {{name.id.camelcase}}
    end

    macro belongs_to(name)
      property {{name.id}} : {{name.id.camelcase}} | Nil = nil
    end

    def to_sql_string : String
      @@name.downcase
    end
  end
end
