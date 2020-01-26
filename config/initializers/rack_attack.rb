class Rack::Attack

  throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.ip unless req.path.start_with?('/assets')
  end

  blocklist("block ip") do |req|
    Rails.cache.read("block #{req.ip}")
  end

  denied = ENV.fetch('RACKATTACK_DENY', "").split(/,\s*/)
  denied_regexp = Regexp.union(denied)
  blocklist("refspam") do |request|
    request.referer =~ denied_regexp
  end

  self.blocklisted_response = lambda do
    [ENV.fetch('THROTTLED_RESPONSE_CODE', 418), {}, ['']]
  end

  self.throttled_response = lambda do
    [ENV.fetch('THROTTLED_RESPONSE_CODE', 418), {}, ['']]
  end
end
