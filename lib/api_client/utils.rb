module ApiClient

  module Utils

    def self.deep_merge(hash, other_hash)
      other_hash.each_pair do |key,v|
        if hash[key].is_a?(::Hash) and v.is_a?(::Hash)
          deep_merge hash[key], v
        else
          hash[key] = v
        end
      end
      hash
    end

  end

end