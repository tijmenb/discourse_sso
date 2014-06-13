require "discourse_sso/version"
require "discourse_sso/config"
require "discourse_sso/request"

# TODO: remove
require "rack"
require "base64"

module DiscourseSSO
  class InvalidSignature < StandardError; end;
end
