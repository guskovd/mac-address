# MacAddress

`mac-address` gem is a clone of @ahoward's `macaddr` gem, and is a suitable
drop-in replacement.

The purpose of this fork is to fix version 1.6.2, which failed to list its
dependencies, and to simplify the development and test environments to allow
easier contribution.

## Installation

Add this line to your application's Gemfile:

    gem 'mac-address'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mac-address

## Usage

`MacAddress` gives you access to your MAC addresses.

~~~ ruby
require 'mac-address'

MacAddress.address
#=> 'c8:bc:c8:9b:28:b1'
MacAddress.address.list
#=> ['c8:bc:c8:9b:28:b1', 'd0:4e:f1:68:29:79'] 
~~~

Or, you can use this as a drop-in replacement for the `macaddr` gem:

~~~ ruby
require 'macaddr'

Mac.address
#=> 'c8:bc:c8:9b:28:b1'
Mac.address.list
#=> ['c8:bc:c8:9b:28:b1', 'd0:4e:f1:68:29:79'] 
~~~

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
