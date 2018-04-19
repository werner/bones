 module Bones
   class SelectColumn
     property column : Column::Definition::Column | AggregateFunctions::AggregateFunction
 
     def initialize(@column = Column)
     end
 
     def to_sql_string
       @column.to_sql_string
     end
   end
 end 
