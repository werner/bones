 module Bones
   class GroupByColumn
     property column : Column
 
     def initialize(@column = Column.new)
     end
 
     def to_sql_string
       @column.to_sql_string
     end
   end
 end 
