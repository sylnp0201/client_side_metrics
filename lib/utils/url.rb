require 'uri'
require 'net/http'

module Utils::Url
  def self.hash_to_query(h)
    h.map{|k,v| "#{k}=#{v}"}.join('&')
  end

  def self.query_to_hash(query)
    hash = {}
    return hash if query.blank?
    query.split('&').each do |q|
      key, val = q.split('=')
      hash[key] = val
    end
    hash
  end

  def self.encode(str)
    URI.escape(str)
  end

  def self.request(url, http_proxy=nil)
    uri = URI.parse(url)
    if http_proxy
      request = Net::HTTP::Get.new(uri.request_uri)
      proxy_addr, proxy_port = http_proxy.split(':')
      proxy = Net::HTTP::Proxy(proxy_addr, proxy_port)
      http_session = proxy.new(uri.host, uri.port)
      http_session.start {|http| http.request(request) }
    else
      Net::HTTP.get_response(uri)
    end
  end
end