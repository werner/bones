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

class Vehicle < Bones::TableDef
end

describe Bones::SQL do
  it "shows a verified typed query" do
    person = Person.new
    worker = Worker.new
    position = Position.new
    vehicle = Vehicle.new

    person_id_column = IdColumn.new(person)
    worker_id_column = IdColumn.new(worker)
    position_id_column = IdColumn.new(position)
    worker_person_id_column = PersonIdColumn.new(worker)
    position_person_id_column = PersonIdColumn.new(position)
    vehicle_person_id_column = PersonIdColumn.new(vehicle)

    person_age_column = AgeColumn.new(person)
    person_name_column = NameColumn.new(person)
    worker_name_column = NameColumn.new(worker)
    person_gender_column = GenderColumn.new(person)

    sql = Bones::SQL.new
    sql.select(person_id_column, person_name_column, worker_name_column)
      .from(person)
      .inner_join(to_table: worker, on: person_id_column.eq(worker_person_id_column))
      .inner_join(to_table: position, on: person_id_column.dup.eq(position_person_id_column))
      .left_join(to_table: vehicle, on: person_id_column.dup.eq(vehicle_person_id_column))
      .where(to_table: worker, column: worker_name_column.eq("Jhon"))
      .to_sql_string
      .should(
    eq("SELECT person.id, person.name, worker.name " +
        "FROM person " +
        "INNER JOIN worker ON person.id = worker.person_id " +
        "INNER JOIN position ON person.id = position.person_id " + 
        "LEFT JOIN vehicle ON person.id = vehicle.person_id " + 
        "WHERE worker.name = 'Jhon'")
    )
  end

  it "throws a ColumnNotEqualTypeException exception" do
    id_column = IdColumn.new
    name_column = NameColumn.new

    expect_raises(Bones::Exceptions::ColumnNotEqualTypeException) do
      id_column.eq(name_column)
    end
  end

  it "throws a ColumnNotEqualValueTypeException exception" do
    id_column = IdColumn.new

    expect_raises(Bones::Exceptions::ColumnNotEqualValueTypeException) do
      id_column.eq("hello")
    end
  end
end
