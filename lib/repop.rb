require "active_record"

$LOAD_PATH.unshift(File.dirname(__FILE__))

require "repop/repop"
require "repop/repopable"

$LOAD_PATH.shift

if defined?(ActiveRecord::Base)
  class ActiveRecord::Base
    include Repop::Repopable
  end
end
