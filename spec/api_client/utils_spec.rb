require "spec_helper"

describe ApiClient::Utils do

  describe '.deep_merge' do

    it "merges two hashes updating the first one" do
      hash_a = { :a => 1, :b => 2  }
      hash_b = { :b => 3, :c => 45 }
      ApiClient::Utils.deep_merge hash_a, hash_b
      hash_a.should == { :a => 1, :b => 3, :c=>45 }
      hash_b.should == { :b => 3, :c => 45 }
    end

    it "deeply merges two hashes recursively" do
      hash_a = { :a => { :foo => 2, :boo => { :wat => 'wat' } }, :b => 2  }
      hash_b = { :b => 3, :c => 45, :a => { :boo => { :wat => "WAT????" } } }
      ApiClient::Utils.deep_merge hash_a, hash_b
      hash_a.should == { :a => { :foo => 2, :boo => { :wat => 'WAT????' } }, :b => 3, :c => 45  }
    end

    it "require correct key type" do
      hash_a = { :a  => 1 }
      hash_b = { 'a' => 2 }
      ApiClient::Utils.deep_merge hash_a, hash_b
      hash_a.should == { :a => 1, 'a' => 2 }

    end

  end

end
