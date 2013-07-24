require 'spec_helper'

describe 'Pulse::XML' do
  describe '#parse' do
    let(:ministry_involvements) { File.read(test_file_path('ministry_involvement/sheldon.xml')) }

    subject { Pulse::XML.parse(ministry_involvements) }

    it 'should return an array' do
      subject.should be_a_kind_of(Array)
    end

    it 'should return a result' do
      subject.size.should be_present
    end

    it 'should return an array of hashes' do
      subject.first.should be_a_kind_of(Hash)
    end

    it 'should return with ministry_involvements' do
      subject.first['ministry_involvements'].should be_present
    end
  end
end