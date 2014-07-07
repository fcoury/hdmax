require 'spec_helper'

describe Schedule do
  describe '#get', :vcr do
    let(:schedules) { Schedule.get(Schedule::CAMPINAS) }
    let(:schedule) { schedules[0] }

    it "sets the city" do
      # http://programacao.netcombo.com.br/gatekeeper/exibicao/select?q=id_cidade:11%20AND%20id_programa:1274475&wt=json&rows=10
      expect(schedule.city_id).to eql("11")
      expect(schedule.city).to eql("campinas")
    end

    it "fetches the channel" do
      expect(schedule.channel.name).to eql("TV Câmara")
    end
  end
end
