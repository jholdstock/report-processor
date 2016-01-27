require_relative "conf"
require_relative "pdf-parser"

require "pp"

# if order number is greater than 4 digits, only include if it is ocado
# if order number is greater than 4 digits and worldstores, create a total row
# value in spreadsheet should be N value
# London in town 

def performNameLookup data, rules
	replacedNames = 0

	data.each do |date, orders|
		orders.map do |order|
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

#pp data
