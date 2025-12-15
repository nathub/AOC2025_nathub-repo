def parse(rotationString)
	rotationString = rotationString.gsub(/\s+/, "")			#Remove all whitespace characters
	directionString = rotationString[0]						#Direction is always first character
	valueString = rotationString[1, rotationString.length]	#Rotation amount is the number in the string.
	#Parse remaining of the string as the rotation amount. If it doesn't parse, set to nil.
	value = valueString.to_i != 0 || valueString.match(/^0+$/) ? valueString.to_i : nil

	#Parse L or l as Left (negative rotation), and R or r as Right (positive). 0 is invalid.
	direction = directionString =~ /[L|l]/ ? -1 : 0
	direction = directionString =~ /[R|r]/ ? 1 : direction

	
	if (value.nil? || direction == 0) then raise "Rotation Parse Error! #{rotationString}" end

	#Results
	puts "Rotation String: #{rotationString}"	if @DEBUG
	puts "Rotation Parsed: #{direction} #{value}"	if @DEBUG
	return value * direction
end

def executeRotation(position, rotation)
	puts "executeRotation"
	puts "Current Position: #{position}, Rotation: #{rotation}"
	passedZeroes = 0
	holder = position + rotation

	while holder > 100 do
		holder -= 100
		passedZeroes += 1
	end

	while holder < 0 do
		holder += 100
		passedZeroes += 1
	end 
	newPosition = (position + rotation)%100
	if position == 0 && rotation < 0 then passedZeroes -= 1 end
	zeroes = newPosition == 0 ? passedZeroes + 1 : passedZeroes
	puts "Execute result: new Pos: #{newPosition}, passedZeroes: #{passedZeroes}, zeroes: #{zeroes}"
	return newPosition, zeroes
end

@DEBUG = false
if __FILE__ == $0
puts "Start."
	if (!ARGV[0].nil?)
		puts "ARGV not nil #{ARGV[0]}"
		position = 50
		count = 0 #number of zeros passed and landed on
		passCount = 0
		File.open(ARGV[0]).each do |rotationString|
			rotation = parse(rotationString)
			puts "Rotation: #{rotation}" if @DEBUG
			puts "Position #{position}" if @DEBUG

			oldPosition = position
			position, thisCount = executeRotation(position, rotation)
			puts "New Position: #{position}, added this many zeroes: #{thisCount}" #if @DEBUG

			count += thisCount
			
			puts "Count: #{count} This Rotation\'s Count: #{thisCount}, Rotation String: #{rotationString}"
		end
	end

end
