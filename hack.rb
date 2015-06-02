require 'uri'
require 'openssl'

str = "BAh7BkkiD3Nlc3Npb25faWQGOgZFVEkiRTMwZDUyNWYzZWRkMzY0ZWZkMmY0%0AODk1MzJkNzIyZmNiZDg2OGYzM2UwYzk3YTQyNWNhYWMzYjk2NDgxYzBjNDIG%0AOwBG%0A--abc1b5f04f16e41592c48d954ee7ff7f5bbe38de"

def decode_session(str)
  Marshal.load(URI.decode_www_form_component(str).unpack("m").first)
end

def generate_hmac(data, secret)
  OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, secret, data)
end

data = decode_session(str)

puts generate_hmac(data["session_id"], "nobody_will_ever_find_me")





