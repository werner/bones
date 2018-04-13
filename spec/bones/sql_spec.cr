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
    sql.select(Bones::Select.new(person, [Bones::SelectColumn.new(id_column), Bones::SelectColumn.new(name_column)]))
      .select(Bones::Select.new(worker, [Bones::SelectColumn.new(name_column)]))
      .from(person)
      .inner_join(Bones::Join.new(worker, id_column, person_id_column))
      .inner_join(Bones::Join.new(position, id_column, person_id_column)).to_sql_string.should(
    eq("SELECT person.id, person.name, worker.name FROM person INNER JOIN worker ON person.id = worker.person_id INNER JOIN position ON person.id = position.person_id")
    )
  end
end
