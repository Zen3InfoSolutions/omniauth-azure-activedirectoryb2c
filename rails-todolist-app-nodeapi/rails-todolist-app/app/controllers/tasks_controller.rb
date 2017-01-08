class TasksController < ApplicationController

  before_filter :create_http

  def create
    request = Net::HTTP::Post.new("/api/tasks")
    request.set_form_data({"Text" => "newtask"})
    request.add_field("Authorization","Bearer " + (session[:omniauth]["credentials"]["token"]))
    @response = @http.request(request)
  end

  def show
    request = Net::HTTP::Get.new("/api/tasks")
    request.add_field("Authorization","Bearer " + (session[:omniauth]["credentials"]["token"]))
    @response = @http.request(request)
  end


  def create_http
    @http = Net::HTTP.new("localhost",8124)
  end
end
