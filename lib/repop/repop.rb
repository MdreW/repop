module Repop
  class Repop < ActiveRecord::Base
    belongs_to :repopable, :polymorphic => true

    validates_presence_of :value
    validates_uniqueness_of :key, :format => { :with => /^[a-z0-9_]*$/, :message => "Only lowercase letters, number, _ allowed" }

    attr_accessible :key, :value

    default_scope order(:key)

    def tkey
      return "{" + self.key + "}"
    end

    def div
      return "option_" + self.to_param
    end
  end
end
