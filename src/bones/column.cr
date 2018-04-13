module Bones
  class Column
    macro declare_type(name, value)
      property {{property.var}} : {{property.type}} = value
    end

    def self.column(name : Int32)
      declare_fields(name, 0)
    end

    def self.column(name : String)
      declare_fields(name, "")
    end

    def self.column(name : Char)
      declare_fields(name, '\'')
    end

    def self.column(name : Nil)
    end

  end
end
