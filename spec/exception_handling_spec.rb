require 'spec_helper'
require 'rest_client'
require 'ostruct'

describe "Exception handling" do
  let(:client) { Pulse::Client }

  subject { client.send(:execute,{}) }

  it "should raise Pulse::Errors::BadRequest on 400" do
    exception = RestClient::Exception.new(OpenStruct.new(code: 400, body: 'message'))
    RestClient::Request.stubs(:execute).raises(exception)
    expect { subject }.to raise_error(Pulse::Errors::BadRequest)
  end

  it "should raise Pulse::Errors::Unauthorized on 401" do
    exception = RestClient::Exception.new(OpenStruct.new(code: 401, body: 'message'))
    RestClient::Request.stubs(:execute).raises(exception)
    expect { subject }.to raise_error(Pulse::Errors::Unauthorized)
  end

  it "should raise Pulse::Errors::Forbidden on 403" do
    exception = RestClient::Exception.new(OpenStruct.new(code: 403, body: 'message'))
    RestClient::Request.stubs(:execute).raises(exception)
    expect { subject }.to raise_error(Pulse::Errors::Forbidden)
  end

  it "should raise Pulse::Errors::NotFound on 404" do
    exception = RestClient::Exception.new(OpenStruct.new(code: 404, body: 'message'))
    RestClient::Request.stubs(:execute).raises(exception)
    expect { subject }.to raise_error(Pulse::Errors::NotFound)
  end

  it "should raise Pulse::Errors::InternalError on 500" do
    exception = RestClient::Exception.new(OpenStruct.new(code: 500, body: 'message'))
    RestClient::Request.stubs(:execute).raises(exception)
    expect { subject }.to raise_error(Pulse::Errors::InternalError)
  end
end