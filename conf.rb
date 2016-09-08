require 'inifile'

$file = IniFile.load('conf.ini')

def getAccNameLookup
	rules = $file["Account Name Lookup"]
	puts "Loaded #{rules.size} lookup rules from conf.ini"
	rules
end

def getPdfName
	general = $file["General Config"]
	general["pdfName"]
end

def getOver6Includes
	$file["Include even if over 6"]["accountNames"].split ","
end