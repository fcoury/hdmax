class Schedule
  CAMPINAS = 11

  attr_reader :id, :version, :start_st, :end_st, :city, :city_id
  attr_reader :title, :title_str, :channel_id

  def self.get_url(city_id)
    "http://programacao.netcombo.com.br/gatekeeper/exibicao/select?q=id_cidade:#{city_id}&wt=json&rows=10000"
  end

  def self.find_url(city_id, start, finish)
    "http://programacao.netcombo.com.br/gatekeeper/exibicao/select?q=id_cidade:#{city_id}&wt=json&@&fq=dh_inicio:%5B#{start}%20TO%20#{finish}%5D&rows=40000"
  end

  def self.fetch(url)
    response = RestClient.get url
    docs = JSON.parse(response)["response"]["docs"]
    docs.map { |doc| Schedule.new(doc) }
  end

  def self.all(city_id)
    fetch get_url(city_id)
  end

  def self.get(city_id, start, finish)
    fetch find_url(city_id, start.utc.iso8601, finish.utc.iso8601)
  end

  def initialize(payload)
    @version = payload["_version"]
    @start_st = payload["dh_inicio"]
    @end_st = payload["dh_fim"]
    @city = payload["st_cidade"]
    @city_id = payload["id_cidade"]
    @genre = payload["genero"]
    @staff = payload["elenco"]
    @id = payload["id_programa"]
    @title = payload["titulo"]
    @title_str = payload["st_titulo"]
    @channel_id = payload["id_canal"]
    @exhibition_id = payload["id_exibicao"]
  end

  def start
    DateTime.parse(start_st).to_time - 3*60*60
  end

  def finish
    DateTime.parse(end_st).to_time - 3*60*60
  end

  def channel
    Channel.find(city_id, channel_id)
  end

  def record!
    request = {
      "hdmax" => {
        "solr_id_exibicao" => @exhibition_id,
        "solr_programa_genero" => nil,
        "solr_id_programa" => @id,
        "solr_programa_subgenero" => nil,
        "solr_canal_categoria" => nil,
        "solr_id_cidade" => @city_id
      }
    }
    RestClient.post "http://test.netapp.ws/api/activity/hdmax", request.to_json,
      content_type: :json,
      accept: :json,
      "AUTH-TOKEN" => Hdmax.config.auth_token
  end
end
