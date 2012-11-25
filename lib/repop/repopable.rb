module Repop
#module Repopable
  def add_repop
    has_many :repops, :as=>:repopable, :dependent=>:destroy, :class_name => "Repop::Repop"
    include InstanceMethods
  end
  module InstanceMethods
    def repopable?
      true
    end
    def replace(text)
      reg = Regexp.new("(#{self.options.map{|o| o.tkey}.join('|')})")
      value = Hash[self.options.map{|o| [o.tkey,o.value]}]
      return text.gsub(reg, value)
    end
  end
end
#end
ActiveRecord::Base.extend Repop
