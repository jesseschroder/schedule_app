ScheduleApp.router.config do
  get "/assignments", :to => "Assignments#index"
  get "/thisweek", :to => "ThisWeek#index"

  post "/assignments", :to => "Assignments#create"
end

