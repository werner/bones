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

class SomeColumn < Bones::Column
  column id : Int32
  column name : String
end

class Person < Bones::TableDef
end

class Worker < Bones::TableDef
end

class Position < Bones::TableDef
end

class Vehicle < Bones::TableDef
end

class Department < Bones::TableDef
end

describe Bones::SQL do
  it "shows a verified typed query" do
    person = Person.new
    worker = Worker.new
    position = Position.new
    vehicle = Vehicle.new
    department = Department.new

    person_id_column = IdColumn.new(person)
    worker_id_column = IdColumn.new(worker)
    position_id_column = IdColumn.new(position)
    worker_person_id_column = PersonIdColumn.new(worker)
    position_person_id_column = PersonIdColumn.new(position)
    vehicle_person_id_column = PersonIdColumn.new(vehicle)
    department_person_id_column = PersonIdColumn.new(department)

    person_age_column = AgeColumn.new(person)
    person_name_column = NameColumn.new(person)
    worker_name_column = NameColumn.new(worker)
    department_name_column = NameColumn.new(department)
    person_gender_column = GenderColumn.new(person)

    sql = Bones::SQL::SQL.new
    # I know this query does not make much sense, but I'm using it as a full example
    sql.select(person_id_column, person_name_column, worker_name_column, sql.sum(person_age_column))
      .from(person)
      .inner_join(to_table: worker, on: person_id_column.eq(worker_person_id_column))
      .inner_join(to_table: position, on: person_id_column.dup.eq(position_person_id_column))
      .left_join(to_table: vehicle, on: person_id_column.dup.eq(vehicle_person_id_column))
      .right_join(to_table: department, on: person_id_column.dup.eq(department_person_id_column))
      .where(worker_name_column.eq("Jhon").and(person_gender_column.eq('M')).or(person_age_column.gt(20)).and(person_id_column.dup.is_not(nil)))
      .order_by(person_id_column.dup.asc)
      .group_by(person_id_column, person_name_column, worker_name_column)
      .having(sql.sum(person_age_column).lt(100).and(sql.count(person_id_column).gt(1)))
      .limit(100)
      .offset(2)
      .to_sql_string
      .should(
    eq("SELECT person.id, person.name, worker.name, SUM(person.age) " +
        "FROM person " +
        "INNER JOIN worker ON person.id = worker.person_id " +
        "INNER JOIN position ON person.id = position.person_id " +
        "LEFT JOIN vehicle ON person.id = vehicle.person_id " + 
        "RIGHT JOIN department ON person.id = department.person_id " + 
        "WHERE worker.name = 'Jhon' AND person.gender = 'M' OR person.age > 20 " +
        "AND person.id IS NOT NULL " +
        "GROUP BY person.id, person.name, worker.name " +
        "HAVING SUM(person.age) < 100 AND COUNT(person.id) > 1 " +
        "ORDER BY person.id ASC " +
        "LIMIT 100 OFFSET 2")
    )
  end

  it "uses the count star" do
    person = Person.new
    sql = Bones::SQL::SQL.new

    sql.select(sql.count_all).from(person).to_sql_string.should eq("SELECT COUNT(*) FROM person")
  end

  it "uses the count star with table" do
    person = Person.new
    sql = Bones::SQL::SQL.new

    sql.select(sql.count_all(person)).from(person).to_sql_string.should eq("SELECT COUNT(person.*) FROM person")
  end

  it "raise a ColumnNotEqualTypeException exception" do
    id_column = IdColumn.new
    name_column = NameColumn.new

    expect_raises(Bones::Exceptions::ColumnNotEqualTypeException) do
      id_column.eq(name_column)
    end
  end

  it "raise a ColumnNotEqualValueTypeException exception" do
    id_column = IdColumn.new

    expect_raises(Bones::Exceptions::ColumnNotEqualValueTypeException) do
      id_column.eq("hello")
    end
  end

  it "raise a OneColumnPropertyException exception" do
    id_column = IdColumn.new

    expect_raises(Bones::Exceptions::OneColumnPropertyException) do
      SomeColumn.new
    end
  end

  it "raise a GroupByMissingColumnException exception" do
    expect_raises(Bones::Exceptions::GroupByMissingColumnException) do
      person = Person.new

      person_id_column = IdColumn.new(person)
      person_name_column = NameColumn.new(person)

      sql = Bones::SQL::SQL.new
      sql.select(person_id_column, person_name_column)
         .from(person)
         .group_by(person_id_column)
    end
  end
end
