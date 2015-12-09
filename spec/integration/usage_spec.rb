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

require "gsheets/session"
require "gsheets/spread_sheet"
require "gsheets/oauth/offline"
require "dotenv"

describe Gsheets::SpreadSheet do
  Given!(:dotenv) { Dotenv.load }
  Given(:client_id) { ENV["client_id"] || "client_id" }
  Given(:client_secret) { ENV["client_secret"] || "client_secret" }
  Given(:refresh_token) { ENV["refresh_token"] || "refresh_token" }
  Given(:spread_sheet_id) { ENV["spread_sheet_id"] || "spread_sheet_id" }
  Given(:authenticator)  { Gsheets::Oauth::Offline.new(client_id, client_secret) }
  Given(:code) { authenticator.get_access_token(refresh_token: refresh_token) }
  Given(:session) { Gsheets::Session.new(auth_code: code) }
  Given(:ss) { Gsheets::SpreadSheet.new(session: session, id: spread_sheet_id) }
  # Then { binding.pry }
end