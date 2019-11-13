require 'spec_helper'

describe Arachni::RPC::Exceptions do

    describe '#rpc_exception?' do
        context 'for RPC exceptions' do
            subject { described_class::InvalidMethod.new.rpc_exception? }
            it { should be_true }
        end

        context 'for other exceptions' do
            subject { ::Exception.new.rpc_connection_error? }
            it { should be_false }
        end
    end

    describe '#rpc_connection_error?' do
        context 'for ConnectionError' do
            subject { described_class::ConnectionError.new.rpc_connection_error? }
            it { should be_true }
        end

        context 'for other exceptions' do
            subject { described_class::InvalidMethod.new.rpc_connection_error? }
            it { should be_false }
        end
    end

    describe '#rpc_remote_exception?' do
        context 'for RemoteException' do
            subject { described_class::RemoteException.new.rpc_remote_exception? }
            it { should be_true }
        end

        context 'for other exceptions' do
            subject { described_class::InvalidMethod.new.rpc_remote_exception? }
            it { should be_false }
        end
    end

    describe '#rpc_invalid_object_error?' do
        context 'for invalid object RPC exceptions' do
            subject { described_class::InvalidObject.new.rpc_invalid_object_error? }
            it { should be_true }
        end

        context 'for other exceptions' do
            subject { ::Exception.new.rpc_invalid_object_error? }
            it { should be_false }
        end
    end

    describe '#rpc_invalid_method_error?' do
        context 'for invalid method RPC exceptions' do
            subject { described_class::InvalidMethod.new.rpc_invalid_method_error? }
            it { should be_true }
        end

        context 'for other exceptions' do
            subject { ::Exception.new.rpc_invalid_method_error? }
            it { should be_false }
        end
    end

    describe '#rpc_invalid_token_error?' do
        context 'for RPC exceptions' do
            subject { described_class::InvalidToken.new.rpc_invalid_token_error? }
            it { should be_true }
        end

        context 'for other exceptions' do
            subject { ::Exception.new.rpc_invalid_token_error? }
            it { should be_false }
        end
    end

end
