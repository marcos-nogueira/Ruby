#encoding: utf-8
class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :update, :destroy]


  # GET /reports/1
  def index
    params.permit!
    report = make_report
    exemple = 'reports?inicio=2019-08-01&fim=2019-08-30'
    if report.nil?
      render json:{message: "Parametros inicio e fim, Sao Obrigatorios, Exemplo: #{exemple}"},status: :unprocessable_entity
    else
      render json: @report
    end
  end


  def make_report
    report = {}
    tot = 0
    #debugger
    order_qty = Order.where(:data.gt => params['inicio'], :data.lt => params['fim'] ).to_a
    order_qty.each do |order|
      tot += order[:total]
    end
    return nil if order_qty.count() == 0
   report['total_sales'] = order_qty.count()
   report['average_ticket'] = tot / order_qty.count()
   @report = report
  end


 end
