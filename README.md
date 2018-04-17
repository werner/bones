# bones [![Build Status](https://travis-ci.org/werner/bones.png)](https://travis-ci.org/werner/bones)

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

# SELECT person.id, person.name, worker.name, SUM(person.age) FROM person INNER JOIN worker ON person.id = worker.person_id 
# INNER JOIN position ON person.id = position.person_id
# LEFT JOIN vehicle ON person.id = vehicle.person_id
# RIGHT JOIN department ON person.id = department.person_id
# WHERE worker.name = 'Jhon' AND person.gender = 'M' OR person.age > 20
# AND person.id IS NOT NULL
# GROUP BY person.id, person.name, worker.name
# HAVING SUM(person.age) < 100 AND COUNT(person.id) > 1
# ORDER BY person.id ASC
# LIMIT 100 OFFSET 2

```

## Contributing

1. Fork it ( https://github.com/werner/bones/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [werner](https://github.com/werner) werner - creator, maintainer
