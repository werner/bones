require "../spec_helper"

class Person < Bones::TableDef
  table_name person
  column id : Int32
  column age : Int32
  column name : String
  column gender : Char

  has_many :worker
  has_many :position
  has_many :vehicle
  has_many :department
end

class Worker < Bones::TableDef
  table_name worker
  column id : Int32
  column person_id : Int32
  column name : String

  belongs_to :person
end

class Position < Bones::TableDef
  table_name position
  column id : Int32
  column person_id : Int32
  column name : String

  belongs_to :person
end

class Vehicle < Bones::TableDef
  table_name vehicle
  column id : Int32
  column person_id : Int32
  column name : String

  belongs_to :person
end

class Department < Bones::TableDef
  table_name department
  column id : Int32
  column person_id : Int32
  column name : String

  belongs_to :person
end

describe Bones::SQL do
  it "shows a verified typed query" do
    person = Person.new
    worker = Worker.new
    position = Position.new
    vehicle = Vehicle.new
    department = Department.new

    person_id = person.id
    worker_id = worker.id
    position_id = position.id
    worker_person_id = worker.person_id
    position_person_id = position.person_id 
    vehicle_person_id = vehicle.person_id
    department_person_id = department.person_id

    person_age = person.age
    person_name = person.name
    worker_name = worker.name
    department_name = department.name
    person_gender = person.gender

    sql = Bones::SQL::SQL.new
    # I know this query does not make much sense, but I'm using it as a full example
    sql.select(person_id, person_name, worker_name, sql.sum(person_age))
      .from(person)
      .inner_join(to_table: worker, on: person_id.dup.eq(worker_person_id))
      .inner_join(to_table: position, on: person_id.dup.eq(position_person_id))
      .left_join(to_table: vehicle, on: person_id.dup.eq(vehicle_person_id))
      .right_join(to_table: department, on: person_id.dup.eq(department_person_id))
      .where(worker_name.eq("Jhon").and(person_gender.eq('M')).or(person_age.gt(20)).and(person_id.is_not(nil)))
      .order_by(person_id.asc)
      .group_by(person_id, person_name, worker_name)
      .having(sql.sum(person_age).lt(100).and(sql.count(person_id).gt(1)))
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
    person = Person.new
    person_id = person.id
    person_name = person.name

    expect_raises(Bones::Exceptions::ColumnNotEqualTypeException) do
      person_id.eq(person_name)
    end
  end

  it "raise a ColumnNotEqualValueTypeException exception" do
    person = Person.new
    person_id = person.id

    expect_raises(Bones::Exceptions::ColumnNotEqualValueTypeException) do
      person_id.eq("hello")
    end
  end

  it "raise a GroupByMissingColumnException exception" do
    expect_raises(Bones::Exceptions::GroupByMissingColumnException) do
      person = Person.new

      person_id = person.id
      person_name = person.name

      sql = Bones::SQL::SQL.new
      sql.select(person_id, person_name)
         .from(person)
         .group_by(person_id)
    end
  end
end
