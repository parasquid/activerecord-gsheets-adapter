require 'spec_helper'

describe ActiveRecord::Gsheets::Adapter do
  context "it has a version number" do
    Given(:version) { ActiveRecord::Gsheets::Adapter::VERSION }
    Then { version != nil }
  end

end
