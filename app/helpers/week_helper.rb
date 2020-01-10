module WeekHelper
  def this_week
    year = Time.now.strftime('%Y').to_i
    week = Time.now.strftime('%V').to_i
    week_start = Date.commercial(year, week, 1)
    week_end = Date.commercial(year, week, 7)

    [week_start, week_end]
  end
end
