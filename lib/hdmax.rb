require "json"
require "rest_client"

require "hdmax/version"
require "hdmax/config"
require "hdmax/channel"
require "hdmax/schedule"

module Hdmax
  def self.config
    @config ||= Config.new
  end
end
