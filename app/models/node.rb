require 'net/http'
require 'elsm'

class Node
  extend ActiveModel::Naming

  attr_accessor :reported_at
  attr_accessor :last_inspect_report_id
  attr_accessor :hidden
  attr_accessor :name
  attr_accessor :updated_at
  attr_accessor :last_apply_report_id
  attr_accessor :description
  attr_accessor :status
  attr_accessor :created_at
  attr_accessor :id

  attr_accessor :instance

  def self.all
    resp = Net::HTTP.get(URI.parse("http://localhost:3000/nodes.json"))
    @nodes = JSON.parse(resp)
    @nodes.collect {|n| Node.new(n)}
  end

  def self.find(id)
    @nodes = all
    @nodes.each do |node|
      if node.name.gsub(".", "_") == id
        return node
      end
    end
    nil
  end

  def to_param
    name.gsub(".", "_")
  end

  def initialize(n)
    @@config ||= YAML::load(File.open("/etc/elsm.yml"))
    @@compute ||= Elsm::Compute.new(:aws, @@config[:aws])
    @@instances ||= @@compute.servers
    @@instances.each do |instance|
      if instance.private_dns_name == n["name"]
        @instance = instance
      end
    end

    n.each do |k,v|
      send("#{k}=", v)
    end
  end
end
