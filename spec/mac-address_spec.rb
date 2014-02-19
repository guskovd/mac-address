# encoding: utf-8
require 'spec_helper.rb'

shared_examples_for 'MacAddress::parse' do
  let(:output) do
    fixture(scenario)
  end
  let(:parsed_result) do
    described_class::parse(output)
  end
  subject { parsed_result }

  it { should be_a_kind_of String }
  it { should match MacAddress::RE }
  its(:list) { should be_a_kind_of Array }
  it { should eql expected }
end

describe MacAddress do
  include Rspec::FixtureLoader

  it { should respond_to :address }

  context '::parse' do
    context 'noifconfig' do
      let(:scenario) { 'noifconfig' }
      let(:expected) { 'd0:4e:f1:68:29:79' }
      include_examples 'MacAddress::parse'
    end
    context 'osx' do
      let(:scenario) { 'osx' }
      let(:expected) { 'c8:bc:c8:9b:28:b1' }
      include_examples 'MacAddress::parse'
    end
    context 'windows' do
      let(:scenario) { 'windows' }
      let(:expected) { '5C-51-4F-AF-09-9C' }
      include_examples 'MacAddress::parse'
    end
  end

  context '::address' do
    before(:each) do
      described_class.instance_variable_set(:@mac_address, nil)
      described_class.stub(:systemu) { |cmd| [0, fixture('osx'), ''] }
    end
    subject { described_class.address }

    it { should match MacAddress::RE }
    it 'should memoize the result' do
      described_class.should_receive(:parse).once.and_call_original
      3.times { described_class.address }
    end
  end
end
