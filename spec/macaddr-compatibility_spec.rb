# encoding: utf-8

describe 'macaddr compatibility' do
  before(:all) { require 'macaddr' }
  context '::Mac' do
    subject { ::Mac }
    it { should eq ::MacAddress }
  end
  context '::MacAddr' do
    subject { ::MacAddr }
    it { should eq ::MacAddress }
  end
  context '::Macaddr' do
    subject { ::Macaddr }
    it { should eq ::MacAddress }
  end
end
