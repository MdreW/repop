module Repop
  module Repopable
    def self.included(base)
      base.extend ClassMethods
    end

    class Manager
      attr_reader :klass

      def initialize klass
        @klass = klass
        setup_relations
      end

      def setup_relations
        klass.has_many :repops , :dependent => :destroy , :as => :repopable, :class_name => "Repop::Repop"
      end
    end
  end

  module InstanceMethods
    def replace(text)
      reg = Regexp.new("(#{self.options.map{|o| o.tkey}.join('|')})")
      value = Hash[self.options.map{|o| [o.tkey,o.value]}]
      return text.gsub(reg, value)
    end
  end

  module ClassMethods
    def add_repop
      include Repop::Repopable::InstanceMethods
    end
  end
end
