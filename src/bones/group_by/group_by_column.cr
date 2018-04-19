 module Bones
   class GroupByColumn
     property column : Column::Definition::Column | Nil
 
     def initialize(@column = nil)
     end
 
     def to_sql_string
       @column.to_sql_string
     end
   end
 end 
