module Repop
  def repop_add(exc = [])
    has_many :repops, :as=>:repopable, :dependent=>:destroy, :class_name => "Repop::Repop"
    accepts_nested_attributes_for :repops, :allow_destroy => true, :reject_if => proc {|o| o['key'].blank? or exc.include?(o['key'])}
    attr_accessible :repop_attributes
    include InstanceMethods
    @@exc = exc
  end
  def repop_local
    return @@exc
  end
  module InstanceMethods
    def repopable?
      return true
    end
    def replace(text)
      return text.gsub(repop_regexp, repop_value)
    end
    def repop_regexp
      local = self.class.repop_local.map{|a| "{#{a.to_s}}"}
      repops = self.repops.map{|o| o.tkey}
      tkeys = local + repops
      return Regexp.new("(#{tkeys.join('|')})")
    end
    def repop_value
      return Hash[self.class.repop_local.map{|o| ["{#{o.to_s}}",send(o)]} + self.repops.map{|o| [o.tkey,o.value]}]
    end
    def world_replace(text)
      return text.gsub(repop_world_regexp, repop_world_value)
    end
    def repop_world_regexp
      local = self.class.repop_local.map{|a| a.to_s}
      repops = self.repops.map{|o| o.key}
      keys = local + repops
      return Regexp.new("(#{keys.join('|')})\\b")
    end
    def repop_world_value
      return Hash[self.class.repop_local.map{|o| [o.to_s,send(o)]} + self.repops.map{|o| [o.key,o.value]}]
    end
  end
end
ActiveRecord::Base.extend Repop
