def checkInvalidIDString(id)
	

	
end


@DEBUG = true
puts "Start."
	if (!ARGV[0].nil?)
		invalidIDs[] = nill
		counter = 0

		invalidIDs = File.open(ARGV[0]).split(',')

		invalidIDs.each do |rangeString|
			rangeEnds = rangeString.split('-')
			lowerRange = rangeEnds[0].to_i
			upperRange = rangeEnds[1].to_i

			targetInt = lowerRange

			while targetInt <= upperRange do
				#convert int back to string, parse string for repeats
			end
		
	else
		puts "No Input File Provided."
	end
		
