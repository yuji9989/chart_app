class ChartPagesController < ApplicationController
  def home
    @end_at = Date.today
    @start_at = @end_at - 6
    @categories = @start_at.upto(@end_at).to_a
    @data = [5, 6, 3, 1, 2, 4, 7]

    @h = LazyHighCharts::HighChart.new("graph") do |f|
      f.chart(:type => "column")
      f.title(:text => "Sample graph")
      f.xAxis(:categories => @categories)
      f.series(:name => "sample",
               :data => @data)
    end
  end
end
