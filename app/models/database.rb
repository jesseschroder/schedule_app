module Database
  module ClassMethods
    private

    def table_columns
      cols = ScheduleApp.database.query("SELECT * FROM #{self.name}s", symbolize_keys: true)
      cols.fields - [:id]
    end

    def query_all(klass)
      ScheduleApp.database.query <<~SQL
        SELECT *
        FROM #{klass.downcase}s
        ;
      SQL
    end

    def query_by_date(start, finish)
      ScheduleApp.database.query <<~SQL
        SELECT *
        FROM #{self.name}s
        WHERE due_date BETWEEN '#{start}' AND '#{finish}'
        ;
      SQL
    end

    def save(instance)
      cols = var_names(instance)
      values = var_values(instance)
      ScheduleApp.database.query <<~SQL
        INSERT INTO #{self.name}s
        (#{cols})
        VALUES (#{values})
        ;
      SQL
      true
    end

    def sanitize(args)
      case args
      when String
        "'#{args.gsub("'", "''")}'"
      when Integer
        return args
      else
        return args
      end
    end
  end

  def test_db_call
    save
  end

  private

  def self.included(base)
    base.extend ClassMethods
  end
end
