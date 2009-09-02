Formal
======

Writing forms suck, it needs to be more formal, pave way for formal, the form helper that makes form designs trivial again, Formal gives you the following things:

- a sensible stylesheet to work with
- same conventions that you are used_to like form_for, etc
- common sense abstractions like wrapping inputs with labels or giving you toggle values
- the ability to use this with the other standard rails helpers

TODO : extend actionview formhelpers using this example : http://hubertlepicki.com/2008/08/07/prototype-rails-spinbox & http://st-on-it.blogspot.com/2008/10/writting-own-form-helper-for-rails.html

USAGE
=====
Examples assume the fields are nested in the following block:

    form_for @something do |f|
      # examples here
    end

input_for :field, options={}
----------------------------
generates a text_field for an object

EX:
      
    f.input_for :first_name
    
    # change the label
    f.input_for :first_name, :label => "Your First Name"
      
password_for :field, options={}      
-------------------------------
generates a password_field for an object

EX:

    f.password_for :password
    
    # with confirmation
    f.password_for :password, :with => :confirmation


radio_for :field, options={}
----------------------------
generates a radio_button 

EX: 

    f.radio_for :option
      
      
checkbox_for :field, options={}      
-------------------------------
generates a checkbox

EX:

    f.checkbox_for :option

fieldset args, &blk
-------------------
generates a fieldset with a legend

EX:
    
    # simple fieldset with a legend
    fieldset "Group of fields" do
      # stuff will go here
    end

    # fieldset with options
    fieldset :legend => "Groups of fields", :class => "something" do
      # stuff will go here
    end

Copyright (c) 2009 [Vann Ek], released under the MIT license
