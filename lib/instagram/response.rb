module Instagram
  class Response
    def initialize(response_hash, ratelimit_hash)
      @response_hash = response_hash
      @pagination = response_hash['pagination']
      @meta = response_hash['meta']
      @ratelimit = ::Hashie::Mash.new(ratelimit_hash)
    end

    attr_reader :pagination
    attr_reader :meta
    attr_reader :ratelimit

    def method_missing(m, *args, &block)
      @response_hash.data ? @response_hash.data.send(m, *args, &block) : @response_hash.send(m, *args, &block)
    end

    def blank?
      @response_hash.blank?
    end

    def to_hash
      @response_hash
    end
  end
end
