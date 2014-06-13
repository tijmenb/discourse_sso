module DiscourseSSO
  class Request
    USER_PROPERTIES = [:name, :username, :email, :about_me,
      :external_email, :external_username, :external_name, :external_id]

    attr_reader :request_payload, :request_signature
    attr_accessor :user

    def initialize(request_payload, request_signature)
      @request_payload = request_payload
      @request_signature = request_signature
      verify_authentic_request!
    end

    def callback_url
      Config.configuration.return_url_base + '?' + Rack::Utils.build_query(callback_parameters)
    end

    private

    def verify_authentic_request!
      raise InvalidSignature unless sign(request_payload) == request_signature
    end

    def sign(stuff_to_sign)
      OpenSSL::HMAC.hexdigest("sha256", Config.configuration.secret, stuff_to_sign)
    end

    def callback_parameters
      sso_payload = Base64.encode64(Rack::Utils.build_query(payload_properties))
      { sso: sso_payload, sig: sign(sso_payload) }
    end

    def payload_properties
      { nonce: request_nonce }.merge(user)
    end

    def request_nonce
      decoded = Base64.decode64(request_payload)
      Rack::Utils.parse_query(decoded).fetch('nonce')
    end
  end
end
