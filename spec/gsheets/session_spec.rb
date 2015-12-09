require "spec_helper"
require "gsheets/session"

describe Gsheets::Session do
  context "sanity check" do
    Given(:session_class) { Gsheets::Session }
    context "it initializes an instance" do
      Given(:code) { "auth_code" }
      When(:session_instance) { session_class.new(auth_code: code) }
      Then { session_instance != nil }
    end

    context "it doesn't initialize without an authentication_code" do
      When(:session_instance) { session_class.new }
      Then { expect(session_instance).to have_failed(ArgumentError) }
    end
  end

  context "retrieval" do
    Given(:session_class) { Gsheets::Session }
    Given(:session) { double("session", get: "{}") }
    Given(:http_client) { double("http_client", new: session) }
    Given(:session_instance) { session_class.new(auth_code: code, http_client: http_client) }
    Given(:code) { "auth_code" }
    Given(:id) { "id" }

    context "connection" do
      When(:conn) { session_instance.connection }
      Then { conn != nil }
      Then { expect(http_client).to have_received(:new).with(/access_token/) }
    end

    context "worksheets" do
      When(:results) { session_instance.get_worksheets(id: id) }
      Then { results != nil }
      Then { expect(session).to have_received(:get).with(/worksheets/) }
    end

    context "documents" do
      context "in cell format" do
        When(:results) { session_instance.get_cells(id: id) }
        Then { results != nil }
        Then { expect(session).to have_received(:get).with(/cells/) }
      end

      context "in list format" do
        When(:results) { session_instance.get_list(id: id) }
        Then { results != nil }
        Then { expect(session).to have_received(:get).with(/list/) }
      end

      context "passed in options" do
        When(:results) { session_instance.get_cells(id: id, options:["min-row=1", "max-row=1"]) }
        Then { results != nil }
        Then { expect(session).to have_received(:get).with(/min-row=1/) }
        Then { expect(session).to have_received(:get).with(/max-row=1/) }
      end

      context "can pass in the grid id" do
        Given(:grid_id) { "grid_id" }
        When(:results) { session_instance.get_cells(id: id, grid_id: grid_id) }
        Then { expect(session).to have_received(:get).with(Regexp.new(grid_id))}
      end
    end
  end
end