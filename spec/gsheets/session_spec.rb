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

end