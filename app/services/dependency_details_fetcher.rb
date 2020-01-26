require "net/https"
require "uri"

class DependencyDetailsFetcher

  attr_reader :dependency

  def initialize(dependency)
    @dependency = dependency
  end

  def fetch
    details = case dependency.package_manager.name.downcase
    when "rubygems" then parse_from_rubygems
    when "npm" then parse_from_npm
    when "pip" then parse_from_pip
    else { url: "", license: "" }
    end
  rescue
    { url: "", license: "" }
  end

  private

  def parse_from_npm
    http = Net::HTTP.new("api.npms.io", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(Net::HTTP::Get.new("/v2/search?q=#{dependency.name}"))
    json = JSON.parse(response.body)
    {
      url: json['results'].first['package']['links']['npm'],
      license: nil
    }
  end

  def parse_from_pip
    http = Net::HTTP.new("pypi.org", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(Net::HTTP::Get.new("/pypi/#{dependency.name}/json"))
    json = JSON.parse(response.body)
    {
      url: json['info']['package_url'],
      license: json['info']['license']
    }
  end

  def parse_from_rubygems
    http = Net::HTTP.new("rubygems.org", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(Net::HTTP::Get.new("/api/v1/gems/#{dependency.name}.json"))
    json = JSON.parse(response.body)
    {
      url: json['project_uri'],
      license: json['licenses'].first
    }
  end

end
