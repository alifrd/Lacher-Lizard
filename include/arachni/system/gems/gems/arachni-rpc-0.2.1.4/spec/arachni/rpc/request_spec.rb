require 'spec_helper'

describe Arachni::RPC::Request do
    subject { described_class.new }

    describe '#message' do
        it 'should be an accessor' do
            subject.message = 'test'
            subject.message.should == 'test'
        end
    end

    describe '#args' do
        it 'should be an accessor' do
            subject.args = %w(test)
            subject.args.should == %w(test)
        end
    end

    describe '#token' do
        it 'should be an accessor' do
            subject.token = 'blah'
            subject.token.should == 'blah'
        end
    end

    describe '#callback' do
        it 'should be an accessor' do
            called = false
            subject.callback = proc { called = true }
            subject.callback.call
            called.should be_true
        end
    end

    describe '#prepare_for_tx' do
        it 'should convert the request to a hash ready for transmission' do
            subject.prepare_for_tx.should be_empty

            described_class.new(
                message:  'obj.method',
                args:     %w(test),
                token:    'mytoken',
                callback: proc{}
            ).prepare_for_tx.should =={
                'args'    => %w(test),
                'message' => 'obj.method',
                'token'   => 'mytoken'
            }
        end
    end

end
