require "spec_helper"
require "active_record"

describe "establishing a connection" do
  Given(:connection) { {adapter: "gsheets"} }
  Given(:ar_base) { ActiveRecord::Base }
  When(:adapter) { ar_base.establish_connection(connection) }
  Then { adapter != nil }
end

class User < ActiveRecord::Base
  ActiveRecord::Base.establish_connection adapter: "gsheets"
end

describe User do
  Given { User }
  When(:all_users) { User.all }
  Then { all_users != nil }
end