require 'spec_helper'

describe 'Pulse::Client' do

  describe '.request' do
    let(:client) { Pulse::Client }

    it 'should raise Pulse::Errors::Unauthorized if api_key is not provided' do
      Pulse.api_key = nil
      expect { client.request('get') }.to raise_error(Pulse::Errors::Unauthorized)
    end

    it 'should raise Pulse::Errors::Unauthorized if guid is not provided' do
      Pulse.api_key = '123123'
      expect { client.request('get') }.to raise_error(Pulse::Errors::Unauthorized)
    end

    it 'should execute restclient requests' do
      Pulse.api_key = '123123'
      Pulse.api_base = 'https://www.example.org'
      RestClient::Request.expects(:execute).returns(stub(body: '<xml></xml>'))
      client.request(:get, { guid: 'guid' })
    end
  end

  describe '.build_opts' do
    let(:params) { { resource: 'resource', guid: 'guid' } }
    let(:expected_result) { { method: :get, timeout: 80, headers: { user_agent: "Pulse RubyClient/#{ Pulse::VERSION }" }, url: "https://www.example.org/api/resource?guid=guid&api_key=123123" } }

    subject { Pulse::Client.send(:build_opts, :get, params) }

    it 'should return correct opts' do
      Pulse.api_key = '123123'
      Pulse.api_base = 'https://www.example.org'
      subject.should == expected_result
    end
  end
end