require 'date'
class Market
	attr_reader :name,
							:vendors,
							:date

	def initialize(name)
		@name = name
		@vendors = []
		@date = Date.today.strftime("%m%d%y")
	end
	
	def add_vendor(vendor)
		@vendors << vendor
	end

	def vendor_names
    @vendors.map(&:name)
  end

	def item_names
    @vendors.flat_map do |vendor|
    	vendor.inventory.map do |item,quantity|
    		item.name
    	end
    end.uniq
  end


  def vendors_that_sell(item)
  	 @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

	def sorted_item_list
		item_names.sort
	end

	def total_inventory
		breakdown = Hash.new

		@vendors.each do |vendor|
			vendor.inventory.map do |item,quantity|
				breakdown[item] ||= {quantity: 0, vendors: []}
				breakdown[item][:quantity] += quantity
				breakdown[item][:vendors] << vendor
			end
		end
		breakdown
	end

	def overstocked_items
		total_inventory.select do |item, breakdown|
       vendors_that_sell(item).length > 1 && 
       breakdown[:quantity] > 50
     end.keys
	end

	def is_enough(item,quantity)
		total_inventory.any? do |item,breakdown|
			quantity < total_inventory[item][:quantity]
		end
	end

	def sell(arg_item,arg_quantity)
		if is_enough(arg_item,arg_quantity) && !arg_item.nil?
			total_inventory[arg_item][:vendors].each do |vendor|
				vendor.inventory.each do |item,quantity|

					vendor.inventory[arg_item] -= quantity unless (vendor.inventory[arg_item] -= quantity) >= 0
					arg_quantity -= vendor.inventory[arg_item]
					vendor.inventory[arg_item] = 0
					next

				end
			end
			true
		else
			false
		end
		
	end
end