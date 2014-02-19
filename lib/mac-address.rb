# encoding: utf-8

require 'rubygems' unless defined?(::Gem)
require 'mac-address/version'
require 'systemu'

##
# Cross platform MAC address determination.  Works for:
# * /sbin/ifconfig
# * /bin/ifconfig
# * ifconfig
# * ipconfig /all
# * cat /sys/class/net/*/address
#
# To return the first MAC address on the system:
#
#   MacAddress.address
#
# To return an array of all MAC addresses:
#
#   MacAddress.address.list
#
module MacAddress
  class << self

    def version
      VERSION
    end

    ##
    # Accessor for the system's first MAC address, requires a call to #address
    # first
    attr_accessor "mac_address"

    ##
    # Discovers and returns the system's MAC addresses.  Returns the first
    # MAC address, and includes an accessor #list for the remaining addresses:
    #
    #   Mac.addr # => first address
    #   Mac.addr.list # => all addresses
    def address
      return @mac_address if defined? @mac_address and @mac_address
      re = %r/[^:\-](?:[0-9A-F][0-9A-F][:\-]){5}[0-9A-F][0-9A-F][^:\-]/io
      cmds = '/sbin/ifconfig', '/bin/ifconfig', 'ifconfig', 'ipconfig /all', 'cat /sys/class/net/*/address'

      null = test(?e, '/dev/null') ? '/dev/null' : 'NUL'

      output = nil
      cmds.each do |cmd|
        status, stdout, stderr = systemu(cmd) rescue next
        next unless stdout and stdout.size > 0
        output = stdout and break
      end
      raise "all of #{ cmds.join ' ' } failed" unless output

      @mac_address = parse(output)
    end

    def parse(output)
      lines = output.split(/\n/)

      candidates = lines.select{|line| line =~ RE}
      raise 'no mac address candidates' unless candidates.first
      candidates.map!{|c| c[RE].strip}

      maddr = candidates.first
      raise 'no mac address found' unless maddr

      maddr.strip!
      maddr.instance_eval{ @list = candidates; def list() @list end }
      maddr
    end

    ##
    # Shorter alias for #address
    alias_method "addr", "address"
  end

  RE = %r/(?:[^:\-]|\A)(?:[0-9A-F][0-9A-F][:\-]){5}[0-9A-F][0-9A-F](?:[^:\-]|\Z)/io
end

