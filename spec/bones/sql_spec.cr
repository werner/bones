require "../spec_helper"

class IdColumn < Bones::Column
  column id : Int32
end

class PersonIdColumn < Bones::Column
  column person_id : Int32
end

class AgeColumn < Bones::Column
  column age : Int32
end

class NameColumn < Bones::Column
  column name : String
end

class GenderColumn < Bones::Column
  column gender : Char
end

class Person < Bones::TableDef
end

class Worker < Bones::TableDef
end

class Position < Bones::TableDef
end

describe Bones::SQL do
  it "query" do
    person = Person.new
    worker = Worker.new
    position = Position.new
    id_column = IdColumn.new
    person_id_column = PersonIdColumn.new
    age_column = AgeColumn.new
    name_column = NameColumn.new
    gender_column = GenderColumn.new

    person.columns << id_column
    person.columns << age_column
    person.columns << name_column
    person.columns << gender_column

    worker.columns << id_column
    worker.columns << person_id_column
    worker.columns << name_column

    position.columns << id_column
    position.columns << person_id_column
    position.columns << name_column

    sql = Bones::SQL.new
    sql.from(person)
      .inner_join(Bones::Join.new(worker, id_column, person_id_column))
      .inner_join(Bones::Join.new(position, id_column, person_id_column))
  end
end
