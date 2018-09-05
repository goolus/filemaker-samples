require 'time'
require 'byebug'
require 'mongoid'
require 'json'

Mongoid.load!('./mongoid.yml', :production)

class Organizer
  include Mongoid::Document
  field :name, type: String
  filed :tel, type: String
  filed :fax, type: String
  filed :contact_staff, type: String
end

class Event
  include Mongoid::Document
  field :event_id, type: Integer
  field :title, type: String
  field :body, type: String
  field :image, type: String
  field :pubDate, type: Date
  index({event_id: 1}, {unique: true, name: 'event_id_index'})
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
    if(data.class == Array)
      Event.destroy_all
      data.each do |event|
        event = Event.new(event)
        if(event.valid?)
          event.save
        end
      end
    else
      event = Event.find_or_initialize_by(event_id: data['event_id'])
      if event.new_record?
        event.attributes = data
        event.save
      else
        event.update_attributes(data)
      end
    end
    result(200, {status: true}.to_json)
  end
  def update
    data = ::JSON.parse(@params.body.read)
    event = Event.find_by(event_id: data['event_id'])
    event.update_attributes(data)
    if(event.valid?)
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
    @query  = Rack::Utils.parse_query(@params.query_string, d = nil)
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
    when 'PATCH','PUT'
      case env['PATH_INFO']
      when '/'
        return update()
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
