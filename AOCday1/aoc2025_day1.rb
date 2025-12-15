def rotate(rotation, position)
	newPosition = position + rotation
	newPosition = newPosition % 100
	return newPosition
end

def parse(rotationString)
	rotationString = rotationString.to_s
	puts "ROTATION: #{rotationString}" if @DEBUG

	directionString = rotationString[0]
	puts "DIRECTION: #{directionString}" if @DEBUG

	amplitudeString = rotationString[1, rotationString.length]
	puts "AMPLITUDE STRING: #{amplitudeString}" if @DEBUG
	if amplitudeString.to_i == 0 && !amplitudeString == "0"
		raise "Invalid rotation value! #{amplitudeString}"
	else
		amplitude = amplitudeString.to_i
	end
		
	
	
	isLetters = /[a-zA-Z]/
	isDirection = /[Ll]|[Rr]/
	isLeft = /[L|l]/
	isRight = /[R|r]/

	direction = 0
	if(directionString.match(isLetters) && directionString.match(isDirection))
		direction = rotationString.match(isLeft) ? -1 : direction
		direction = rotationString.match(isRight) ? 1 : direction
		
	elsif directionString.isLetters
		puts "invalid direction #{directionString}"

	else
		puts "rotation must start with a letter: #{rotationString}"
	end

	puts "DIRECTION VALUE: #{direction}" if @DEBUG
	puts "AMPLITUDE VALUE: #{amplitude}" if @DEBUG

	return direction * amplitude
	
end


@DEBUG == false
if __FILE__ == $0
	inputFileName = ARGV[0] ? ARGV[0] : nil
	position = 50
	count = 0

	if(!inputFileName.nil? && !inputFileName.empty?)
		File.open(inputFileName).each do |rotationString|
			rotationString = rotationString.gsub(/\s+/, "") #removes all whitespace
			rotation = parse(rotationString)
			puts "ROTATION VALUE: #{rotation}" if @DEBUG
			if rotation == 0 || !rotation.is_a?(Integer) then raise "Invalid Rotation parsed, exiting!!!" end

			position = rotate(rotation, position)
			puts "POSITION: #{position}" if @DEBUG
			count += position == 0 ? 1 : 0
			puts "COUNT: #{count}" if @DEBUG
		end
	else
		raise "File name not provided."
	end

	puts "FINAL COUNT: #{count}"
end
