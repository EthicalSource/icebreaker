require "net/https"
require "uri"

class DependencyDetailsFetcher

  attr_reader :dependency

  def initialize(dependency)
    @dependency = dependency
  end

  def source_code_url
    case dependency.package_manager.name.downcase
    when "rubygems" then parse_from_rubygems
    when "npm" then parse_from_npm
    else "#"
    end
  rescue
    "#"
  end

  private

  def parse_from_npm
    http = Net::HTTP.new("api.npms.io", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(Net::HTTP::Get.new("/v2/search?q=#{dependency.name}"))
    json = JSON.parse(response.body)
    return json['results'].first['package']['links']['npm']
  end

  def parse_from_rubygems
    http = Net::HTTP.new("rubygems.org", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(Net::HTTP::Get.new("/api/v1/gems/#{dependency.name}.json"))
    return JSON.parse(response.body)['project_uri']
  end

end
