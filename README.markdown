Formal
======

Writing forms suck, it needs to be more easier, and more... formal, formal is a form builder/helper/thing that makes designing forms fun again, Formal gives you the following things:

- a sensible stylesheet to work with
- same conventions that you are used_to like form_for, etc
- common sense abstractions like wrapping inputs with labels or giving you toggle values
- doesn't constrain you to a esoteric form building dsl, so you still have the ability to use this with the other standard rails form helpers like text_field, text_area, etc.
- some nice view helpers to do things like zebra striping 

**WARNING : I just started this so it's still under intense development, fork or use at your own risk!**

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

Copyright (c) 2009 [Vann Ek], released under the MIT license
