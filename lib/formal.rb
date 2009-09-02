module FormalHelper
  def self.included(base)
    ActionView::Helpers::FormBuilder.instance_eval do
      include FormalBuilder
    end
  end
end

module FormalBuilder
  
  # EX : 
  #     
  #    f.input_for :first_name
  #    f.input_for :first_name, :label => "My first name"
  #    f.input_for :first_name, :label => {:value => "My first name", :class => "big"}
  #    f.input_for :first_name, :label => {:value => "My first name", 
  #                :class => "big"}, :class => "text_field_class"
  # CONTINUE HERE 
  def input_for(method, options={})
    options[:label] ||= @object_name.humanize
    lbl = label_for(method, options[:label])
    options.delete :label
    
    lbl << @template.text_field(@object_name, method, options)
  end

  # EX:
  # 
  # f.label_for :first_name
  # f.label_for :first_name, "My First Name"
  # f.label_for :first_name, :value => "My First name", :class => "big"
  def label_for(method, opts_or_val)
    if opts_or_val.is_a?(String)
      return @template.label @object_name, method, opts_or_val
    elsif opts_or_val.is_a?(Hash)
      val = opts_or_val[:value]
      opts_or_val.delete :value
      return @template.label @object_name, method, val, opts_or_val
    end
  end
end
