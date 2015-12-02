require 'spec_helper'

describe Activerecord::Gsheets::Adapter do
  context "it has a version number" do
    Given(:version) { Activerecord::Gsheets::Adapter::VERSION }
    Then { version != nil }
  end

end
