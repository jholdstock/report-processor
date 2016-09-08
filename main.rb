require_relative "conf"
require_relative "pdf-parser"

require "pp"

# if order number is greater than 4 digits and worldstores, create a total row
# value in spreadsheet should be N value
# London in town 

def deleteOver6digits data, lll
		data.each do |date, orders|
			orders.delete_if do |order|
				order[:orderNo].length > 4
			end
		end

	data
end

def performNameLookup data, rules
	replacedNames = 0

	data.each do |date, orders|
		orders.each do |order|
			rules.each do |k, v|
				replaced = order[:accountName].gsub! k, v
				replacedNames += 1 if replaced
			end
		end
	end

	puts "Changed #{replacedNames} account names using rules from conf.ini"

	data
end

data = getDataFromPdf()

accNameLookup = getAccNameLookup()
data = performNameLookup(data, accNameLookup)

over6Includes = getOver6Includes()
data = deleteOver6digits(data, over6Includes)

pp data
