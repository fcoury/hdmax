class Channel
  attr_reader :id, :category, :category_id, :name, :channel

  def self.url(city_id)
    "http://programacao.netcombo.com.br/gatekeeper/canal/select?q=id_cidade:#{city_id}&wt=json&rows=500"
  end

  def self.all(city_id)
    @channels ||= {}
    @channels[city_id] ||= fetch_channels(city_id).inject({}) { |hash, c| hash[c.id] = c; hash }
  end

  def self.fetch_channels(city_id)
    response = RestClient.get url(city_id)
    docs = JSON.parse(response)["response"]["docs"]
    docs.map { |doc| Channel.new(doc) }
  end

  def self.find(city_id, id)
    all(city_id)[id]
  end

  def initialize(payload)
    @id = payload["id_canal"]
    @category = payload["categoria"]
    @category_id = payload["id_categoria"]
    @name = payload["nome"]
    @channel = payload["cn_canal"]
  end
end
