class Facebook
  class << self
    def fbgraph(token)
      Koala::Facebook::API.new(token)
    end

    def get_object(token, id, args = {}, options = {}, &block)
      fbgraph(token).get_object(id, args, options, &block)
    end

    def get_connections(token, id, connection_name, args = {}, options = {}, &block)
      fbgraph(token).get_connections(id, connection_name, args, options, &block)
    end
  end
end