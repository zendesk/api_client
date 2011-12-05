require "spec_helper"

describe ApiClient::Base do

  describe "subclasses" do

    it "inherit scopes, hooks, namespace and format" do

      class Level1InheritanceTest < ApiClient::Base
      end

      Level1InheritanceTest.default_scopes.should   == []
      Level1InheritanceTest.connection_hooks.should == []
      Level1InheritanceTest.namespace.should        == nil
      Level1InheritanceTest.format.should           == :json

      Level1InheritanceTest.default_scopes   = ['scope1']
      Level1InheritanceTest.connection_hooks = ['hook1']
      Level1InheritanceTest.namespace        'level1'
      Level1InheritanceTest.format           :xml

      ApiClient::Base.default_scopes.should   == []
      ApiClient::Base.connection_hooks.should == []
      ApiClient::Base.namespace.should        == nil
      ApiClient::Base.format.should           == :json

      class Level2InheritanceTest < Level1InheritanceTest
        namespace "level2"
        format    :yaml
      end

      Level2InheritanceTest.default_scopes.should   == ['scope1']
      Level2InheritanceTest.connection_hooks.should == ['hook1']
      Level2InheritanceTest.namespace.should        == 'level2'
      Level2InheritanceTest.format.should           == :yaml

      Level1InheritanceTest.namespace.should == 'level1'
      Level1InheritanceTest.format.should    == :xml

    end

  end

end