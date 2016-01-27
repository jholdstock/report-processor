require 'inifile'
	
def getAccNameLookup
	file = IniFile.load('conf.ini')
	rules = file["Account Name Lookup"]
	puts "Loaded #{rules.size} lookup rules from conf.ini"
	rules
end

def getPdfName
	file = IniFile.load('conf.ini')
	general = file["General Config"]
	general["pdfName"]
end