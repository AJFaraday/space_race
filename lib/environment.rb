require 'gosu'
require 'yaml'

require "#{File.dirname(__FILE__)}/config.rb"
require "#{File.dirname(__FILE__)}/zorder.rb"
require "#{File.dirname(__FILE__)}/flyer.rb"
require "#{File.dirname(__FILE__)}/opponents/base.rb"
require "#{File.dirname(__FILE__)}/opponents/simple.rb"
require "#{File.dirname(__FILE__)}/star.rb"
require "#{File.dirname(__FILE__)}/path.rb"

class Hash
  def transform_keys!
    keys.each do |key|
      self[yield(key)] = delete(key)
    end
    self
  end

  def stringify_keys!
    transform_keys!{ |key| key.to_s }
  end
end
