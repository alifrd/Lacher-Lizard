=begin

    This file is part of the Arachni-RPC project and may be subject to
    redistribution and commercial restrictions. Please see the Arachni-RPC
    web site for more information on licensing and terms of use.

=end

module Arachni
module RPC

# Represents an RPC message, serves as the basis for {Request} and {Response}.
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>
class Message

    # @param    [Hash]   opts
    #   Sets instance attributes.
    def initialize( opts = {} )
        opts.each_pair { |k, v| send( "#{k}=".to_sym, v ) }
    end

    # Merges the attributes of another message with self.
    #
    # (The param doesn't *really* have to be a message, any object will do.)
    #
    # @param    [Message]   message
    def merge!( message )
        message.instance_variables.each do |var|
            val = message.instance_variable_get( var )
            instance_variable_set( var, val )
        end
    end

    # Prepares the message for transmission (i.e. converts the message to a `Hash`).
    #
    # Attributes that should not be included can be skipped by implementing
    # {#transmit?} and returning the appropriate value.
    #
    # @return   [Hash]
    def prepare_for_tx
        instance_variables.inject({}) do |h, k|
            h[normalize( k )] = instance_variable_get( k ) if transmit?( k )
            h
        end
    end

    # Decides which attributes should be skipped by {#prepare_for_tx}.
    #
    # @param    [Symbol]    attr
    #   Instance variable symbol (i.e. `:@token`).
    def transmit?( attr )
        true
    end

    private

    def normalize( attr )
        attr.to_s.gsub( '@', '' )
    end

end

end
end
