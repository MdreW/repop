repop 0.1.0 (Stable version)
====================

gem for replacing text based on a research key

This gem is  derived from "[Distlist](https://github.com/MdreW/distlist)" project ( https://github.com/MdreW/distlist ) and his work is replace the text according to the keys and values

Installation
------------

In your gemfile

	gem "repop"

Then at the command line
	
	bundle install

Create the migration at the command line

	rails generate repop:migration

Logic
-----

Repop  generates a polymorphic table named "repops". This table have a key field and a value field. A repopable model is connected with "repops" table with a "has_many". Repops gem adds automatically the connection, configure the model for acceptance of "nested_attributes" and make accessible the "repops_attributes" method.
In the last add all necessary methods for replace a text based on keys of the model.

Usage
-----

In your model

	class UserModel < ActiveRecord::Base
		repopable
	end	

If your wont include some local fields as keys

    class UserModel < ActiveRecord::Base
		repopable [:email, :name]
	end	

### add keys/values

for adds a key value pair using nested attributes (this example [use simple_forms](https://github.com/plataformatec/simple_form))

In your controller:
    
    @User = User.find(params[:id]) # or whatever you want
    @User.repops.build # if your want to prepare a empty pair

In your view

    = simple_form_for @user do |f|
      = f.error_notification

      .form-inputs
        = f.input :email
        = f,input :name

        = f.simple_fields_for :repops do |o|
          = o.input :key
          = o.input :value
          = o.input :_destroy, :as => :select, :include_blank => false, :default => false

      .form-actions
        = f.button :submit

Without use of "nested_attributes" is same of each other model

  @user = User.find(params[:id]) # or whatever you want
  @user.repops.create(key: "a_key", value: "a_value")

### text replacement

The "replace" methods find the keys including braces

	str = "Good morning mister {name}, his car {car} is repaired."
	user = User.first
	user.replace(str) -> "Good morning mister Andrea, his car Fusion 1.6 is repaired."

The "world_replace" methods find any word boundary

	str = "Good morning mister name, his car is repaired."
	user = User.first
	user.world_replace(str) -> "Good morning mister Andrea, his Fusion 1.6 is repaired."

The "repop_regexp" method return a keys regexp with all params and the "repop_value" method return the value for regexp. These methods are usable with "gsub".

	user - User.first
	"Good morning mister {name}, his car {car} is repaired.".gsub(user.repop_regexp, user.repop_value)
	 # same as "user.replace("text")"

The "repop_world_regexp" method return a world regexp and "repop_world_value" method return its value. These methods are usable with "gsub".

	user - User.first
	"Good morning mister name, his car is repaired.".gsub(user.repop_world_regexp, user.repop_world_value)
	# same as "user.world_replace("text")"

### The next episode:

* good spec test
* class method for search by options or by keys
* a simplified helper
* more documentation

### Collaborate

* fork me
* send your code
* tell me your code
* join
* Bring me a coffee
