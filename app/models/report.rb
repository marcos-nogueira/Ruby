class Report
  include Mongoid::Document
  field :start_date, type: Time
  field :end_date, type: Time
  field :average_ticket, type: Float
end
