require 'integrations/spec_helper'


require 'integrations/lab_resource_shared'

# model requirement

# To move in search_shared
#
#
shared_examples_for "search" do |count|
  context "#search" do
    let(:parameters) { { :model => searched_model, :criteria => criteria} } 
    context "create" do
      let(:expected_json) do
        path = "http://example.org/#{uuid}"
        { "search" => {"actions" => {"read" => path,
          "first" => "#{path}/page=1",
          "last" => "#{path}/page=-1",
        },
          "uuid" => uuid,
        }
        }
      end
      context "as a resource" do
        it_behaves_like "creating a resource"
      end

      context "create via action" do
        it_behaves_like "creating a resource", "/search/create_search"
      end
    end
  end
end

shared_examples_for "empty search" do
  it_behaves_like "search", 0
end

#
# end to move in search_shared
#

shared_context "with 0 plate" do
  let(:plate_ids) do
    []
  end
end

shared_context "with 10 saved plates" do
  let(:plate_ids) do
    []
  end
end

describe "Lims::Core::Persistence::Search"do
  include_context "use core context service", :plates, :samples, :searches
  include_context "JSON"
  let(:model) { "searches" }

  context "#plate" do
    let(:searched_model) { "plate" }
    include_context "has standard dimension"
    context "with 0 plate" do
      let(:criteria) { { :id => [1,2,5,7,8] } }
      it_behaves_like ("empty search")
    end

    context "with some plates" do
      include_context "with 10 saved plates"
      let(:criteria) { { :id => [1,2,5,7,8].map { |i| plate_ids[i] } }}
      #it_behaves_like ("search", {:count => 5})
      it_behaves_like "search"
    end

  end
end
