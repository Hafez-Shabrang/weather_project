class PagesController < ApplicationController

  def home
  end

  def search
    require 'net/http'
    require 'json'
    require 'date'
    @city = params[:search][:city].capitalize
    @url = "https://api.openweathermap.org/data/2.5/weather?q=#{@city}&appid=7cf6bed45018a2fc95b6153aa30917e2"
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @weather = JSON.parse(@response)

    @country = @weather["sys"]["country"]
    @city = @weather["name"]
    @temp = ((@weather["main"]["temp"].to_f) - 273.15).round(2)
    @feels = ((@weather["main"]["feels_like"]) - 273.15).round(2)
    @hum = @weather["main"]["humidity"]
    @zone = DateTime.strptime(@weather["dt"].to_s,'%s')
    render :home
  end
end
