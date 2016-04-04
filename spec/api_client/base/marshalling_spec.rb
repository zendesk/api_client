require "spec_helper"

describe "Marshaling of ApiClient objects" do
  ConnectionProc = Proc.new {}
  AlwaysProc = Proc.new {}

  class Entity < ApiClient::Base
    connection &ConnectionProc
    always &AlwaysProc

    def mutated_state?
      @state == "mutated"
    end

    def mutate_state!
      @state = "mutated"
    end
  end

  it "is marshallable by default" do
    scope = Entity.params(:foo => 1).headers("token" => "aaa").options("some" => "option")
    entity = scope.build :key => "value"

    entity.mutated_state?.should == false
    entity.mutate_state!
    entity.mutated_state?.should == true

    reloaded = Marshal.load(Marshal.dump(entity))

    reloaded.should == entity
    reloaded.mutated_state?.should == true
  end
end
