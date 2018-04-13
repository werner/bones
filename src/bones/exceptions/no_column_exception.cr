module Bones::Exceptions
  class NoColumnException < Exception
    property column : String
    property table : String

    def initialize(@column = "", @table = "", message = "")
      super("No #{@column} column defined for #{@table} table")
    end
  end
end
