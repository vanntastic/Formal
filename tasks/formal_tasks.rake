require 'fileutils'
PUBLIC_PATH = File.expand_path(File.join(RAILS_ROOT, "public"))
FORMAL_PATH = File.expand_path(File.join(RAILS_ROOT,"vendor/plugins/formal"))

namespace :formal do
  
  desc 'Install the asset files'
  task :install do
    public_css_path = File.join(PUBLIC_PATH,"stylesheets")
    public_js_path = File.join(PUBLIC_PATH,"javascripts","jquery.validate")
    Dir.mkdir public_js_path unless File.exists?(public_js_path)
    
    css = Dir.glob(File.join(FORMAL_PATH,"stylesheets","*.css"))
    js = Dir.glob(File.join(FORMAL_PATH,"javascripts","jquery-validate","*.js"))
    
    FileUtils.cp_r(css, public_css_path)
    FileUtils.cp_r(js, public_js_path)
    
    puts "All Formal files installed!"
    puts "------------------------------------------"
    puts "just insert <%= include_formal %> in the head of"
    puts "your document to get started"
    puts "------------------------------------------"
  end
  
end
