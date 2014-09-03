require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    def initialize(req, route_params = {})
      @params = route_params
      
      parse_www_encoded_form(req.query_string)
      parse_www_encoded_form(req.body) if req.body
      
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      return if www_encoded_form.nil?
      URI::decode_www_form(www_encoded_form).each do |key, val|
        keys = parse_key(key)
        if keys.count == 1
          @params[key] = val
        else
          make_nested_hash(keys, val)
          # @params.merge!(recursive_nested_hash(keys + [val] ))
        end
      end
    end
    
    def make_nested_hash(keys, val)
      sub_hash = @params[keys.first] ||= {}
      keys[1...-1].each do |key|
        sub_hash = sub_hash[key] ||= {}
      end
      
      sub_hash[keys.last] = val
    end
    
    def recursive_nested_hash(keys)
      if keys.count == 2
        return { keys.first => keys.last }
      else
        { keys.first => recursive_nested_hash(keys[1..-1]) }
      end
    end
        
      

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
