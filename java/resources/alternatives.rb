#
# Author:: Pradeep Kumar Potu (<pradeep.potu@harman.com>)
# Cookbook Name:: java
# Recipe:: alternatives

actions :set, :unset

attribute :java_location, :kind_of => String, :default => nil
attribute :bin_cmds, :kind_of => Array, :default => nil
attribute :default, :equal_to => [true, false], :default => true
attribute :priority, :kind_of => Integer, :default => 1061
attribute :reset_alternatives, :equal_to => [true, false], :default => true

# we have to set default for the supports attribute
# in initializer since it is a 'reserved' attribute name
def initialize(*args)
  super
  @action = :set
end
