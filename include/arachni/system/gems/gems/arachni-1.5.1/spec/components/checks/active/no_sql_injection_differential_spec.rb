require 'spec_helper'

describe name_from_filename do
    include_examples 'check'

    def self.platforms
        [:nosql]
    end

    def self.elements
        [ Element::Form, Element::Link, Element::Cookie ]
    end

    def issue_count
        6
    end

    easy_test
end
