require 'net/http'

class NodesController < ApplicationController
  def index
    @nodes = Node.all
  end

  def graph
    @node = Node.find(params[:id])
    resp = Net::HTTP.get(URI.parse("http://localhost:8080/render?from=-2h&width=460&height=320&target=#{params[:target]}"))
    send_data(resp, :type => "image/png")
  end

  def show
    @node = Node.find(params[:id])
  end
end
