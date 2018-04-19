 module Bones
   class OrderByColumn
     property sql : SQL::SQL | Nil
 
     def initialize(@sql = nil)
     end
 
     def to_sql_string
       @column.to_sql_with_sort_op_string
     end
   end
 end 
