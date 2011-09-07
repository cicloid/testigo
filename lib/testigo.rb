require "api_smith"
require "date"
require "testigo/version"

module Testigo
  class Error < StandardError; end
  
  class Incident < APISmith::Smash
    property :id, :from => :incidentid
    property :title, :from => :incidenttitle
    property :description, :from => :incidentdescription
    property :date, :from => :incidentdate, :transformer => lambda { |v| Date.parse(v) }
    property :mode, :from => :incidentmode
    property :active, :from => :incidentactive
    property :verified, :from => :incidentverified
    property :location_id, :from => :locationid
    property :location, :from => :locationname
    property :latitude, :from => :locationlatitude
    property :longitude, :from => :locationlongitude
  end

  class Category < APISmith::Smash
    property :id
    property :title
    property :description
    property :color
  end
  
  class IncidentsCollection < APISmith::Smash
    property :incidents, :transformer => lambda { |c| c.map { |v| [Incident.call(v['incident']), Category.call(v['Categories'].first) ] }.flatten }
  end
    
  def self.collection_transformers
    @collection_transformers ||= Hash.new do |h, k|
      h[k] = Class.new(StatsCollection).tap do |klass|
        klass.transformer_for :items, k
      end
    end
  end
  
  class Client
    include APISmith::Client
    format :json
    
    attr_reader :base, :path
    
    def initialize(base, path)
      self.class.base_uri base
      self.class.endpoint path
    end

    def base_query_options
      {:resp => 'json'}
    end
    
    def get_incidents(options = {})
      # a = get '/api', :extra_query => { :task => 'incidents' }, :response_container => , :transform => IncidentsCollection
      #       puts a
      #       # 
      response = get '/api', :extra_query => { :task => 'incidents', :limit => 1000 }, :response_container => ['payload'], :transformer => IncidentsCollection
    end
    
    private
    
    def check_response_errors(response)
      # if response.is_a?(Hash)
      #   # and (error = response['error'] unless response['error']['code'] != "0")
      #   # raise Error.new(error)
      # end
    end
    
  end
  
end                                         
