# bones

A SQL Query Builder for Crystal.


## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  bones:
    github: werner/bones
```

## Usage

```crystal
require "bones"

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

class Department < Bones::TableDef
end

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
```

## Contributing

1. Fork it ( https://github.com/werner/bones/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [werner](https://github.com/werner) werner - creator, maintainer
