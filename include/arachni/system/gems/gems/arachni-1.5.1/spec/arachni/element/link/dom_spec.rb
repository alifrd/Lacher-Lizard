require 'spec_helper'

describe Arachni::Element::Link::DOM do
    inputs = { 'param' => '1' }

    it_should_behave_like 'element_dom'
    #
    it_should_behave_like 'with_node'
    it_should_behave_like 'with_auditor'

    it_should_behave_like 'locatable_dom'
    it_should_behave_like 'submittable_dom'
    it_should_behave_like 'inputtable_dom', inputs: inputs
    it_should_behave_like 'mutable_dom',    inputs: inputs
    it_should_behave_like 'auditable_dom'

    def auditable_extract_parameters( page )
        { 'param' => Nokogiri::HTML(page.body).css('#container').text }
    end

    def run
        auditor.browser_cluster.wait
    end

    before :each do
        @framework = Arachni::Framework.new
        @page      = Arachni::Page.from_url( "#{url}/link" )
        @auditor   = Auditor.new( @page, @framework )

        @link = @page.links.first.dom
        @link.auditor = @auditor
    end

    after :each do
        @framework.clean_up
        @framework.reset
    end

    subject { @link }
    let(:parent) { @link.parent }
    let(:url) { web_server_url_for( :link_dom ) }
    let(:auditor) { @auditor }
    let(:inputtable) do
        l = Arachni::Page.from_url( "#{url}/link/inputtable" ).links.first.dom
        l.auditor = auditor
        l
    end

    describe '#type' do
        it 'returns :link_dom' do
            expect(subject.type).to eq(:link_dom)
        end
    end

    describe '.type' do
        it 'returns :link_dom' do
            expect(described_class.type).to eq(:link_dom)
        end
    end

    describe '#parent' do
        it 'returns the parent element' do
            expect(subject.parent).to be_kind_of Arachni::Element::Link
        end
    end

    describe '#inputs' do
        it 'parses query-style inputs from URL fragments' do
            expect(subject.inputs).to eq({ 'param' => 'some-name' })
        end
    end

    describe '#fragment' do
        it 'returns the URL fragment' do
            expect(subject.fragment).to eq('/test/?param=some-name')
        end
    end

    describe '#fragment_path' do
        it 'returns the path from the URL fragment' do
            expect(subject.fragment_path).to eq('/test/')
        end
    end

    describe '#fragment_query' do
        it 'returns the query from the URL fragment' do
            expect(subject.fragment_query).to eq('param=some-name')
        end
    end

    describe '#trigger' do
        it 'triggers the event required to submit the element' do
            inputs = { 'param' => 'The.Dude' }
            subject.update inputs

            called = false
            subject.with_browser do |browser|
                subject.browser = browser

                subject.trigger

                expect(subject.inputs).to eq(auditable_extract_parameters( browser.to_page ))
                called = true
            end

            subject.auditor.browser_cluster.wait
            expect(called).to be_truthy
        end

        it 'returns a playable transition' do
            inputs = { 'param'  => 'The.Dude' }
            subject.update inputs

            transitions = []
            called = false
            subject.with_browser do |browser|
                subject.browser = browser
                browser.load subject.page

                transitions = subject.trigger

                page = browser.to_page

                expect(subject.inputs).to eq(auditable_extract_parameters( page ))
                called = true
            end

            subject.auditor.browser_cluster.wait
            expect(called).to be_truthy

            called = false
            auditor.with_browser do |browser|
                browser.load subject.page
                expect(auditable_extract_parameters( browser.to_page )).to eq(
                    { 'param' => '' }
                )

                transitions.each do |transition|
                    transition.play browser
                end

                expect(auditable_extract_parameters( browser.to_page )).to eq(inputs)
                called = true
            end
            auditor.browser_cluster.wait
            expect(called).to be_truthy
        end
    end

    describe '.data_from_node' do
        it 'returns a hash with DOM data' do
            expect(described_class.data_from_node( subject.node )).to eq({
                inputs:         {
                    'param' => 'some-name'
                },
                fragment:       '/test/?param=some-name',
                fragment_path:  '/test/',
                fragment_query: 'param=some-name'
            })
        end

        it 'decodes inputs' do
            html = "<a href='#/?stuff%20here=bl%20ah'>Stuff</a>"
            node = Nokogiri::HTML.fragment(html).children.first

            expect(described_class.data_from_node( node )[:inputs]).to eq({
                'stuff here' => 'bl ah'
            })
        end

        context 'when there is no URL fragment' do
            let(:node) do
                Nokogiri::HTML.fragment( "<a href='/stuff/here'>Stuff</a>" ).
                    children.first
            end

            it 'return nil' do
                expect(described_class.data_from_node( node )).to be_nil
            end
        end

        context 'when there are no inputs' do
            let(:node) do
                Nokogiri::HTML.fragment( "<a href='/stuff/here#blah'>Stuff</a>" ).
                    children.first
            end

            it 'return nil' do
                expect(described_class.data_from_node( node )).to be_nil
            end
        end
    end

end
