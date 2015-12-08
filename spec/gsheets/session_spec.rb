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

  context "retrieve the document" do
    Given(:session_class) { Gsheets::Session }
    Given(:connection) { double("connection", get: "{}") }
    Given(:http_client) { double("http_client", new: connection) }
    Given(:session_instance) { session_class.new(auth_code: code, http_client: http_client) }
    Given(:code) { "auth_code" }
    context "in cell format" do
      Given(:id) { "id" }
      When(:results) { session_instance.get_cells(id: id) }
      Then { results != nil }
      Then { expect(connection).to have_received(:get).with(/cells/) }
    end
  end

end