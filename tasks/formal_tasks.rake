require 'fileutils'
PUBLIC_PATH = File.expand_path(File.join(RAILS_ROOT, "public"))
FORMAL_PATH = File.expand_path(File.join(RAILS_ROOT,"vendor/plugins/formal"))

namespace :formal do
  
  desc 'Install the asset files'
  task :install do
    public_css_path = File.join(PUBLIC_PATH,"stylesheets")
    css = Dir.glob(File.join(FORMAL_PATH,"stylesheets","*.css"))
    
    FileUtils.cp_r(css, public_css_path)
    
    puts "All Formal files installed!"
    puts "------------------------------------------"
    puts "just insert <%= stylesheet_link_tag 'formal' %> in the head of"
    puts "your document to get started"
    puts "------------------------------------------"
  end
  
end
