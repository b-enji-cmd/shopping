require './lib/item'
require 'minitest/autorun'

class ItemTest < Minitest::Test
	def setup
		@item1 = Item.new({name: 'Peach', price: "$0.75"})
	end

	def test_it_is
		assert_instance_of Item, @item1
	end

end