require 'spec_helper'

class TestResource < Pulse::BaseResource
  resource :test
end

describe 'resourceful' do

  before do
    Pulse.api_key = '12341234'
    Pulse.api_base = 'https://www.example.com'
    Pulse::Client.stubs(:request).returns([{}])
  end

  describe '.resource' do
    it 'sets resource_name' do
      TestResource.resource_name.should eq :test
    end
  end

  describe '#initialize' do
    subject { TestResource.new({ id: 123, 'email' => 'test@gmail.com' }) }

    it 'returns resource instance with attributes' do
      subject.id.should eq 123
      subject.email.should eq 'test@gmail.com'
    end
  end

  describe '.build_from' do
    subject { Pulse::Resource.build_from(response, { resource: 'test' }) }

    context 'when response is an Array of hashes' do
      let(:response) { [{name: 'Adrian'}, {name: 'Sheldon'}] }
      it 'returns an Array' do
        subject.should be_a_kind_of(Array)
      end
      it 'returns an Array of resource objects' do
        subject.first.should be_a_kind_of(Pulse::Resource)
      end
    end

    context 'when response is a hash' do
      let(:response) { {name: 'Adrian'} }
      it 'returns a resource object' do
        subject.should be_a_kind_of(Pulse::Resource)
      end
    end

    context 'when response is a string' do
      let(:response) { "Some string response" }
      it 'returns a string' do
        subject.should == "Some string response"
      end
    end
  end

  describe '.where' do
    it 'should respond to where' do
      TestResource.should respond_to(:where)
    end
    it 'should return an array' do
      c = TestResource.where
      c.should be_a_kind_of(Array)
    end
  end

end