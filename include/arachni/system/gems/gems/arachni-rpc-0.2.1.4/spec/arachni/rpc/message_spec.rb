require 'spec_helper'

class MyMessage < Arachni::RPC::Message
    attr_accessor :foo
    attr_accessor :boo

    def transmit?( attr )
        attr == :@boo
    end
end

describe Arachni::RPC::Message do
    let(:options) { { foo: 'foo val', boo: 'boo val' }}
    subject { MyMessage.new( options ) }

    describe '#initialize' do
        it 'sets attributes' do
            subject.foo == options[:foo]
            subject.boo == options[:boo]
        end
    end

    describe '#merge!' do
        it 'assigns the attribute values of the provided object to self' do
            opts = { foo: 'my foo' }
            my_msg = MyMessage.new( opts )

            subject.merge!( my_msg )

            subject.foo == opts[:foo]
            subject.boo == options[:boo]
        end
    end

    describe '#prepare_for_tx' do
        it 'converts self into a hash' do
            subject.prepare_for_tx.class.should == Hash
        end

        it 'skips attributes based on #transmit?' do
            subject.prepare_for_tx.should include 'boo'
            subject.prepare_for_tx.should_not include 'callback_id'
            subject.prepare_for_tx.should_not include 'foo'
        end
    end

end
