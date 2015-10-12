class ChartPagesController < ApplicationController
  def home
    @end_at = Date.today
    @start_at = @end_at - 6
    @categories = @start_at.upto(@end_at).to_a
    @temperature_data = [25, 26, 27.5, 22, 24, 23, 22.5]
    @illuminance_data = [420, 410, 430, 160, 300, 430, 150]
    @presence_data = [3, 2, 0, 4, 4, 3, 5]
    
    @h = LazyHighCharts::HighChart.new("graph") do |f|
 #     f.chart(:zoomType => "xy")
      f.title(:text => "温度グラフ")
      f.subtitle(:text => "企画部フロア")
      f.xAxis(:categories => @categories,
              :crosshair => true)
      f.yAxis [{ # Presence yAxis
        :labels => {
          :format => '{value} 人',
          :style => {
            :color => 1
          }
        },
        :title => {
          :text => '在席数',
          :style => {
            :color => 1
          }
        },
        :gridLineWidth => 0
      }, { # Temperature yAxis
        :labels => {
          :format => '{value}°C',
          :style => {
            :color => 2
          }
        },
        :title => {
          :text => '温度',
          :style => {
            :color => 2
          }
        },
        :opposite => true
      }, { # Illuminance yAxis
        :labels => {
          :format => '{value} lx',
          :style => {
            :color => 0
          }
        },
        :title => {
          :text => '照度',
          :style => {
            :color => 0
          }
        },
        :opposite => true
      }]
      f.legend(
        :layout => 'vertical',
        :align => 'left',
        :x => 80,
        :verticalAlign => 'top',
        :y => 55,
        :floating => true,
      )
      f.tooltip(:shared => true)
      f.series(:name => "在席", :type => 'column', :yAxis => 0, :data => @presence_data,
        :tooltip => {
          :valueSuffix => ' 人'
        }
      )
      f.series(:name => "温度", :type => 'spline', :yAxis => 1, :data => @temperature_data,
        :tooltip => {
          :valueSuffix => ' ℃'
        }
      )
      f.series(:name => "照度", :type => 'spline', :yAxis => 2, :data => @illuminance_data,
        :tooltip => {
          :valueSuffix => ' lx'
        }
      )
    end
  end
end