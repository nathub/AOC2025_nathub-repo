def parse(rotationString)
	rotationString = rotationString.gsub(/\s+/, "")
	directionString = rotationString[0]
	valueString = rotationString[1, rotationString.length]

	value = valueString.to_i != 0 || valueString.match(/^0+$/) ? valueString.to_i : nil
	
	direction = directionString =~ /[L|l]/ ? -1 : 0
	direction = directionString =~ /[R|r]/ ? 1 : direction

	if (value.nil? || direction == 0) then raise "Rotation Parse Error! #{rotationString}" end
	
	return value * direction
end

@DEBUG == true
if __FILE__ == $0
puts "Start."
	if (!ARGV[0].nil?)
		puts "ARGV not nil #{ARGV[0]}"
		position = 50
		File.open(ARGV[0]).each do |rotationString|
			rotation = parse(rotationString)
			puts "Rotation: #{rotation}" if @DEBUG
			puts "Position #{position}" if @DEBUG
			position = position + rotation
			puts "New Position: #{position}" if @DEBUG
			puts "Mod Position: #{position%100}" if @DEBUG
		end
	end

end
