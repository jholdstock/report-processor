require "pdf-reader"

def getDataFromPdf
	pdfName = getPdfName()
	reader = PDF::Reader.new(pdfName)

	puts "Parsing file '#{pdfName}'"

	allText = ""
	reader.pages.each do |page|
		allText += page.text
	end

	matches = allText.scan /^\s* (\w+)  \s+  (\w+)  \s+ (.+) \s+  (\d+)  \s+ ([\d.,]+)  \s+  ([\d.,]{2,})   $/x

	parsedWithDate = {}

	parsed = []
	totalOrders = 0
	matches.each do	|m|
		if (m[0].strip == "Subtotal") 
			parsedWithDate[m[2].strip] = parsed
			parsed = []
		else
			totalOrders += 1
			t = {
				:orderNo     => m[0].strip,
				:accountCode => m[1].strip,
				:accountName => m[2].strip,
				:lines       => m[3].strip,
				:gValue      => m[4].strip,
				:nValue      => m[5].strip
			}
			parsed.push t
		end
	end

	puts "Found #{totalOrders} orders over #{parsedWithDate.size} dates" 

	parsedWithDate
end