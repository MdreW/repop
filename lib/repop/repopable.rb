module Repop
  def add_repop
    has_many :repops, :as=>:repopable, :dependent=>:destroy, :class_name => "Repop::Repop"
    include InstanceMethods
  end
  module InstanceMethods
    def repopable?
      true
    end
    def replace(text)
      reg = Regexp.new("(#{self.repops.map{|o| o.tkey}.join('|')})")
      value = Hash[self.repops.map{|o| [o.tkey,o.value]}]
      return text.gsub(reg, value)
    end
    def repop_regexp
      return Regexp.new("(#{self.repops.map{|o| o.tkey}.join('|')})")
    end
    def repop_value
      return Hash[self.repops.map{|o| [o.tkey,o.value]}]
    end
  end
end
ActiveRecord::Base.extend Repop
