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

def zerosPassed(oldPosition, newPosition, rotation)
	oldHundreds = oldPosition / 100
	newHundreds = newPosition / 100
	diff = oldHundreds - newHundreds
	special = rotation %100

	puts "Old, New, and Diffrence: #{oldPosition} #{oldHundreds} #{newPosition} #{newHundreds} #{diff}" if @DEBUG
	puts "Special: #{special}" if @DEBUG

	return special == 0 ? diff.abs - 1 : diff.abs
end

@DEBUG = true
if __FILE__ == $0
puts "Start."
	if (!ARGV[0].nil?)
		puts "ARGV not nil #{ARGV[0]}"
		position = 50
		count = 0 #number of zeros passed and landed on
		File.open(ARGV[0]).each do |rotationString|
			rotation = parse(rotationString)
			puts "Rotation: #{rotation}" if @DEBUG
			puts "Position #{position}" if @DEBUG
			oldPosition = position
			position = position + rotation
			puts "New Position: #{position}" if @DEBUG
			passed = zerosPassed(oldPosition, position, rotation)
			puts "Passed Zeros: #{passed}" if @DEBUG
			onZero = position%100 == 0 ? 1 : 0
			count += (onZero + passed)
			puts "Mod Position: #{position%100}" if @DEBUG
			position = position % 100

			puts "Count: #{count}"
		end
	end

end
