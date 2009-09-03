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
  #    # say you wanted to default your text_field
  #    f.input_for :first_name, :default => "Enter your first name"
  #    f.input_for :first_name, :hint => "Enter your first name"
  #    f.input_for :first_name, :label => "My first name"
  #    f.input_for :first_name, :label => {:val => "My first name", :class => "big"}
  #    f.input_for :first_name, :label => {:val => "My first name", 
  #                :class => "big"}, :class => "text_field_class"
  def input_for(method, options={})
    options[:class] ||= ""
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
    # the common method that will be called to build the preceding tags
    def build_tags(method, options)
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
      options[:value] = options[:default] unless options[:default].nil?
      opts = %w(label hint default checked unchecked)
      opts.each {|o| options.delete o}
      return options
    end
end

module FormalViewHelpers
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
