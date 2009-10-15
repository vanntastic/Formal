module FormalHelper
  def self.included(base)
    ActionView::Helpers::FormBuilder.instance_eval do
      include FormalBuilder
    end
  end
end

module FormalBuilder
  include ActionView::Helpers::TagHelper
  
  # EX : 
  #     
  #    f.input_for :first_name
  #    # make sure that it's required
  #    f.input_for :first_name, :required => true
  #    # say you wanted to default your text_field
  #    f.input_for :first_name, :default => "Enter your first name"
  #    f.input_for :first_name, :hint => "Enter your first name"
  #    f.input_for :first_name, :label => "My first name"
  #    f.input_for :first_name, :label => {:val => "My first name", :class => "big"}
  #    f.input_for :first_name, :label => {:val => "My first name", 
  #                :class => "big"}, :class => "text_field_class"
  # 
  def input_for(method, options={})
    content = build_tags(method,options)
    if options[:default].nil?
      return content << @template.text_field(@object_name, method, 
                                               sanitize_opts(options))
    else
      return @template.text_field(@object_name, method, sanitize_opts(options))                                         
    end
  end
  
  # EX:
  # 
  # f.text_area_for :notes
  # 
  def text_area_for(method, options={})
    content = build_tags(method,options)
    if options[:default].nil?
      return content << @template.text_area(@object_name,method,sanitize_opts(options))
    else
      return @template.text_area(@object_name, method, sanitize_opts(options))
    end
  end
  
  # EX:
  #   
  #   f.password_for :password
  #   f.password_for :password_confirmation, :label => "Confirm Password"
  def password_for(method,options={})
    content = build_tags(method,options)
    content << @template.password_field(@object_name,method,sanitize_opts(options))
  end
  
  # EX:
  # 
  # f.radio_for :option, "checked"
  # f.radio_for :option, "Select Option", :label => {:class => "special"}
  def radio_for(method, val, options={})
    options[:label] = setup_option_label(options[:label],val)
    lbl = label_for(method,options[:label])
    options.delete :label
    
    @template.radio_button(@object_name, method, val, options) << lbl
  end
  
  # TODO : finish this method 
  def radios_for(method, vals, options={})
    
  end
  
  # EX:
  # 
  # f.checkbox_for :option
  # f.checkbox_for :option, "Yes", :checked => "yes", :unchecked => "no"
  # f.checkbox_for :option, :label => {:val => "Something"}
  # 
  def checkbox_for(method,val=nil,options={})
    val ||= method.to_s.humanize
    options[:id] ||= "#{@object_name}_#{method}_#{val.downcase}"
    checked = (options[:checked] ||= "1")
    unchecked = (options[:unchecked] ||= "0")
    options[:label] = setup_option_label(options[:label],val)
    lbl = setup_label_for(method, options[:label])
    options.delete :label
    @template.check_box(@object_name,method,options,checked,unchecked) << lbl
  end
  
  # TODO : finish this method 
  def checkboxes_for(method,vals,options={})
    
  end
  
  # EX:
  # 
  # f.select_for :gender
  # f.select_for :gender, ["Male","Female"]
  # f.select_for :gender, ["Male","Female"], :label => {:val => "Select Gender"}
  # 
  def select_for(method,choices,options={})
    content = build_tags(method,options)
    options.delete :label
    content << @template.select(@object_name,method,choices,options)
  end
  
  # EX:
  # 
  # f.date_select_for :dob
  # f.date_select_for :dob, :order => [:month,:day,:year], :label => {:val => "Date of Birth"}
  # f.date_select_for :dob, :required => true, :label => {:val => "Date of Birth"}
  # 
  def date_select_for(method,options={},html_options={})
    content = build_tags(method,options)
    html_options[:class] = html_options[:class].nil? ? "inline" : (html_options[:class] << " inline")
    options.delete :label
    content << @template.date_select(@object_name,method,options,html_options)
  end
  
  # EX:
  # 
  # f.datetime_select_for :appt
  # f.datetime_select_for :appt
  # f.datetime_select_for :appt, :order => [:month,:day,:year], 
  #                              :label => {:val => "Date of Birth"}
  # f.datetime_select_for :appt, :required => true, :label => {:val => "Date of Birth"}
  #
  def datetime_select_for(method,options={},html_options={})
    content = build_tags(method,options)
    html_options[:class] = html_options[:class].nil? ? "inline" : (html_options[:class] << " inline")
    options.delete :label
    content << @template.datetime_select(@object_name,method,options,html_options)
  end
  
  
  # EX:
  # 
  # f.label_for :first_name
  # f.label_for :first_name, "My First Name"
  # f.label_for :first_name, :val => "My First name", :class => "big"
  def label_for(method, opts_or_val)
    if opts_or_val.is_a?(String)
      return @template.label @object_name, method, opts_or_val
    elsif opts_or_val.is_a?(Hash)
      val = opts_or_val[:val]
      opts_or_val.delete :val
      return @template.label @object_name, method, val, opts_or_val
    end
  end
  
  protected
    # the common method that will be called to build the preceding tags before the field
    def build_tags(method, options)
      options[:class] ||= ""
      options[:label] ||= method.to_s.humanize
      options[:label] << " *" if options[:required]
      content = setup_label_for(method, options[:label]) 
      content = add_hint_to(options[:hint],content)
      return content
    end
    
    def add_hint_to(hint,lbl)
      return lbl if hint.nil?
      lbl << content_tag(:span, hint, :class => "hint")
    end
    
    # for checkboxes and radioboxes
    def setup_option_label(lbl,val)
      if lbl.nil?
         lbl = {:val => val,:value => val,:class => "inline"}
       else
         lbl_class = lbl[:class].nil? ? "inline" : (lbl[:class] << " inline")
         lbl.update(:class => lbl_class, :val => val, :value => val)
       end
       return lbl
    end
    
    def setup_label_for(method, lbl)
      lbl ||= method.to_s.humanize
      label_for(method, lbl)
    end
    
    # gets rid of non html options and sets sensible defaults
    def sanitize_opts(options)
      options[:required] ||= false
      options[:class] ||= ""
      options[:value] = options[:default] unless options[:default].nil?
      # add required class if require is passed as true
      options[:class] = options[:required] ? (options[:class] << " required") : options[:class]
      opts = %w(label hint default checked unchecked required)
      opts.each {|o| options.delete o.to_sym}
      return options
    end
end

module FormalViewHelpers
  
  # includes all the files needed for formal
  # EX : 
  # include_formal # => default setup, just css files
  # include_formal :validation => true # => includes jquery validate
  def include_formal(options={})
    options[:validation] ||= false
    
    content = stylesheet_link_tag("formal", :cache => "formal")
    
    if options[:validation]
      content << javascript_include_tag("jquery.validate/jquery.metadata.js",
                                        "jquery.validate/jquery.form.js",
                                        "jquery.validate/jquery.validate.min.js",
                                        "jquery.validate/additional-methods.js",
                                        "jquery.validate/load-validations.js",
                                        :cache => "jquery-validate")
    end
    content
  end
  
  # wrap any features still in development with this method, remove when ready for production
  # EX : still_in_development { my_new_feature }
  # OR
  #   still_in_development do
  #     some cool feature that you are working on... 
  #   end
  def still_in_development(&blk)
    yield unless Rails.env == "production"
  end
  
  # some view standard helpers
  
  # this will generate the html for alternating rows
	# the alternating row classes will default to cycle('alt','reg')
	# EX : zebra_stripes do
	#      # add in your data here
	#      end      
	# striping other tags:
	#      zebra_stripes :tag => :tr do
	#      # my data output here
	#      end
	def zebra_stripes(options={}, &block)
	  # you want to be able to keep it consistent with the cycle function 
    options[:tag] ||= :li
    options.delete :tag
	  options[:row_classes] ||= ["alt","reg"]
    # we have to set the options[:class] to "" or it might error out expecting
    # options[:class] to be an Array
	  options[:class] ||= ""
	  options[:class] = options[:class] << 
	                    " #{cycle(options[:row_classes][0],options[:row_classes][1])}"
	  options.delete :row_classes
	  concat content_tag(tag, capture(&block), options), block.binding
	end
  
  alias :stripes :zebra_stripes
end
