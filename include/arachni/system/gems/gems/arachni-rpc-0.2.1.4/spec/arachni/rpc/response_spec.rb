require 'spec_helper'

describe Arachni::RPC::Response do
    subject { described_class.new }

    describe '#obj' do
        it 'should be an accessor' do
            subject.obj = 'test'
            subject.obj.should == 'test'
        end
    end

    describe '#exception' do
        it 'should be an accessor' do
            subject.exception = 'test'
            subject.exception.should == 'test'
        end
    end

    describe '#exception?' do
        context 'when #exception is not set' do
            it 'returns false' do
                subject.exception?.should be_false
            end
        end

        context 'when #exception is set' do
            it 'returns true' do
                subject.exception = 'stuff'
                subject.exception?.should be_true
            end
        end
    end

    describe '#async?' do
        context 'by default' do
            it 'should return false' do
                subject.async?.should be_false
            end
        end

        context 'after #async!' do
            it 'should return false' do
                subject.async!
                subject.async?.should be_true
            end
        end
    end
end
