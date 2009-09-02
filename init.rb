# Include hook code here
require 'formal'

ActionView::Base.send :include, FormalHelper
ActionView::Base.send :include, FormalViewHelpers
