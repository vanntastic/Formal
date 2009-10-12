Formal
======

Writing forms suck, it needs to be more easier, and more... formal, formal is a form builder/helper/thing that makes designing forms fun again, Formal gives you the following things:

- a sensible stylesheet to work with
- same conventions that you are used_to like form_for, etc
- common sense abstractions like wrapping inputs with labels or giving you toggle values
- doesn't constrain you to a esoteric form building dsl, so you still have the ability to use this with the other standard rails form helpers like text_field, text_area, etc.
- some nice view helpers to do things like zebra striping 
- includes the [jquery.validate](http://docs.jquery.com/Plugins/Validation) plugin if you don't want to use active record validation.

**WARNING : I just started this so it's still under intense development, fork or use at your own risk!**

INSTALLATION
============

- Run:

        ./script/plugin install http://github.com/vanntastic/Formal
        rake formal:install

- Add the following to your layout file (in the head) :

        <%= include_formal %>
        // if you want jquery.validate to be included (requires jquery):
        <%= include_formal :validation => true %>

USAGE
=====
Examples below assume the fields are nested in block similar to:

    <% form_for @user do |f| %>
      # examples here
    <% end %>

Here's a simple example:

    # instead of writing this:
    <% form_for @user do |f| %>
      <%= f.label :first_name %>
      <%= f.text_field :first_name %>
      <%= f.label :last_name %>
      <%= f.text_field :last_name %>
    <% end -%>

    # using formal, you can do this:
    <% form_for @user do |f| -%>
      <%= f.input_for :first_name, :required => true %>
      <%= f.input_for :last_name %>
    <% end -%>

input_for :field, options={}
----------------------------
generates a text_field for an object with a label, takes the same options as text_field,
pass in the label option to change it.

EX:
      
    <%= f.input_for :first_name %>
    
    # change the label
    <%= f.input_for :first_name, :label => "Your First Name" %>
    
    # set a default one line text_field
    <%= f.input_for :first_name, :default => "Please enter in your name" %>
    
    # you can also make sure that this is set to be required
    <%= f.input_for :first_name, :required => true %>
    
    # make more changes to the label, :val is the value of the label
    <%= f.input_for :first_name, :label => {:val => "Please enter in your name", :class => "something"} %>
    
text_area_for :field, options={}    
--------------------------------
generates a text_area field for an object with a label, takes same options as input_for

EX:

    <%= f.text_area_for :comments %>
  
    # make the field required
    <%= f.text_area_for :comments, :required => true %>
    
password_for :field, options={}      
-------------------------------
generates a password_field for an object with a label, works just like input_for with the same exact options.

EX:

    <%= f.password_for :password %>
    
    # change the label
    <%= f.password_for :password, :label => {:val => "Enter password", :class => "pass"} %>

radio_for :field,'value', options={}
----------------------------
generates a radio_button with a label

EX: 
    
    # default setup
    <%= f.radio_for :option %>
    
    # change the default label
    <%= f.radio_for :option, "Select Option" %>

    # change the label
    <%= f.radio_for :option, "Select your option", :label => {:class => "options"} %>
      
      
checkbox_for :field, options={}      
-------------------------------
generates a checkbox

EX:
    
    # default setup
    <%= f.checkbox_for :option %>

    # change the label
    <%= f.checkbox_for :option, "Select your option" %>

    # change the label
    <%= f.checkbox_for :option, "Select your option", :label => {:class => "options"} %>

zebra_stripes options={}, &blk
------------------------------
Zebra stripes allows you to wrap data output (like records and such) in zebra stripes, make sure you set the **'reg' or 'alt'** class in your stylesheet so that it gets a proper background color:

EX:

    # instead of doing something like:
    <%= content_tag :li, data, :class => cycle('alt','reg')  %>
  
    # you can do assuming you are using list items to output your data:
    <% zebra_stripes do -%>
      # your data
    <% end -%>
  
    # you can also use the stripes alias, if zebra_stripes is too much to type
    <% stripes do -%>
      # your data
    <% end -%>

    # what if you were using a table?
    <% stripes :tag => :tr do -%>
      # your data
    <% end -%>
  
    # what if you wanted to pass in html options?
    <% stripes :class => "nice" do -%>
      # your data
    <% end -%>
  
    # the row class defaults to using 'alt' or 'reg', but you can change it
    <% stripes :row_classes => ["none","hi-lite"] do -%>
      # your data
    <% end -%>

Copyright (c) 2009 [Vann Ek], released under the MIT license
