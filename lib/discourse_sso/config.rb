module DiscourseSSO
  class Config
    attr_accessor :secret, :return_url_base

    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Config.new
    end

    def self.configure
      yield(configuration)
    end
  end
end
