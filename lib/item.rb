class Item
	attr_reader :name
	def initialize(args)
		@name = args[:name]
		@price = args[:price]
	end
	
	def price
		@price[1..-1].to_f
	end
end