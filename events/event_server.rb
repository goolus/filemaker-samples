require 'time'
require 'byebug'
require 'mongoid'
require 'json'

Mongoid.load!('./mongoid.yml', :production)

class Event
  include Mongoid::Document
  field :event_id, type: Integer
  field :organizer, type: String
  field :title, type: String
  field :body, type: String
  field :image, type: String
  field :pubDate, type: Date
end

class EventServer
  def index(type = :text)
    events = Event.all
    path = template_path("index.html.erb")
    case type
    when :text
      content = ERB.new(File.read(path)).result(binding)
    when :json
      content = events.to_json
    end
    result(200, :text , content)
  end
  def show(type = :text)
    event = Event.find(@query['id'])
    path = template_path("show.html.erb")
    case type
    when :text
      content = ERB.new(File.read(path)).result(binding)
    when :json
      content = event.to_json
    end
    result(200, type, content)
  end
  def create
    data = ::JSON.parse(@params.body.read)
    event = Event.new(data)
    if(event.valid?) 
      event.save
      result(200, {status: true}.to_json)
    else 
      result(500, {status: false}.to_json)
    end
  end

  def destroy
    Event.destroy_all
  end
  
  def call(env)
    @params = Rack::Request.new(env)
    @query  = Rack::Utils.parse_query(@params.query_string, d =nil)
    case env['REQUEST_METHOD']
    when 'GET'
      case env['PATH_INFO']
      when '/','/index'
        return index()
      when '/index.json'
        return index(:json)
      when '/show'
        return show()
      when '/show.json'
        return show(:json)
      else
        result(404, {status: 404})
      end
    when 'POST'
      case env['PATH_INFO']
      when '/'
        return create()
      else
        result(404, {status: 404})
      end
    when 'DELETE'
      case env['PATH_INFO']
      when '/'
        return destroy()
      end
    end
  end
  
  private
  def result(status, type = :json, content)
    case type
    when :json
      content_type = 'application/json'
    when :html, :text
      content_type = 'text/html'
    end
    
    [ status,
      {'Content-Type' => content_type},
      [content]
    ]
  end
  def template_path(template)
    return File.expand_path("../views/#{template}", __FILE__)
  end
end
