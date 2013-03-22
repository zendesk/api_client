require 'spec_helper'

describe ApiClient::Resource::NameResolver do
  describe '.resolve' do
    subject { described_class }

    it 'changes My::Namespace::MyResouce to my_resource' do
      subject.resolve('My::Namespace::MyResource').should == 'my_resource'
    end

    it 'changes Resource to resource' do
      subject.resolve('Resource').should == 'resource'
    end

    it 'changes My::Resource to resoure' do
      subject.resolve('My::Resource').should == 'resource'
    end
  end
end
