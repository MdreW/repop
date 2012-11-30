  
require 'rubygems'
require 'bundler/setup'

require 'repop'
require 'activerecord'

Bundler.require
require File.expand_path('../../lib/repop.rb', __FILE__)
 
RSpec.configure do |config|
  # some (optional) config here
end

db_name = 'sqlite3'
database_yml = File.expand_path('../database.yml', __FILE__)

active_record_configuration = YAML.load_file(database_yml)
  
ActiveRecord::Base.configurations = active_record_configuration
config = ActiveRecord::Base.configurations[db_name]
  
ActiveRecord::Base.establish_connection(db_name)
ActiveRecord::Base.connection
ActiveRecord::Base.establish_connection(config)
    
ActiveRecord::Base.logger = Logger.new(File.join(File.dirname(__FILE__), "debug.log"))
ActiveRecord::Base.default_timezone = :utc
  
ActiveRecord::Base.silence do
  ActiveRecord::Migration.verbose = false
    
  load(File.dirname(__FILE__) + '/schema.rb')
  load(File.dirname(__FILE__) + '/models.rb')
end  
  
def clean_database!
  models = [RocketTag::Tag, RocketTag::Tagging, TaggableModel, RocketTag::AliasTag]
  models.each do |model|
    ActiveRecord::Base.connection.execute "DELETE FROM #{model.table_name}"
  end
end

clean_database!
