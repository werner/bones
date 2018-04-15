 module Bones
   class OrderByColumn
     property column : Column
 
     def initialize(@column = Column.new)
     end
 
     def to_sql_string
       @column.to_sql_with_sort_op_string
     end
   end
 end 
