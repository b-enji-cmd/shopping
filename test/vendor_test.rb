require './lib/item'
require './lib/vendor'
require 'minitest/autorun'

class VendorTest < Minitest::Test
	def setup
		@item1 = Item.new({name: 'Peach', price: "$0.75"})
		@item2 = Item.new({name: 'Tomato', price: '$0.50'})
		@vendor = Vendor.new("Rocky Mountain Fresh")
	end

	def test_it_is
		assert_instance_of Vendor, @vendor
	end

	def test_it_has_things
		assert_equal "Rocky Mountain Fresh", @vendor.name
		expected = {}
		assert_equal expected, @vendor.inventory 
	end

end
