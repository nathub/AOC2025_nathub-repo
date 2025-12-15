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
	counter = 0
	while rotation != 0 do
		puts "While Do Position #{position}, rotation #{rotation}, passedZeroes #{passedZeroes}."
		if(position + rotation < 0) 
			puts "IS LESS THAN ZERO - P+R #{position + rotation}, P #{position}, R #{rotation}"
			rotation += position != 0 ? position : position
			passedZeroes += 1
			position = 0
			puts "LESS THAN RESULT: Rotation: #{rotation}, passedZeroes #{passedZeroes}, position: #{position}."
		elsif(position + rotation > 100)
			puts "IS GREATER THAN HUNDRED - P+R #{position + rotation}, P #{position}, R #{rotation}"
			rotation -= (100 - position)
			passedZeroes += 1
			position = 0
		else
			puts "IS WITHIN BOUNDS - P+R #{position + rotation}, P #{position}, R #{rotation}"
			position = position + rotation
			rotation = rotation - rotation
		end
		counter+= 1
		if counter > 10 then raise "Loop has gone 10 times, raising error!" end
	end
	puts "passedZeroes: #{passedZeroes}"
	puts "Position Result: #{position}"
	position = position % 100 #In the event it is 100, make it 0
	zeroes = position == 0 ? passedZeroes + 1 : passedZeroes
	return position%100 , zeroes
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
