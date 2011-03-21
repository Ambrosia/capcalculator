#!/usr/bin/env ruby

class Connection
#store everything in kilobytes
number_regex = /^[\d.?]+/
kb_regex = /\d+k[a-z]*$/i
mb_regex = /\d+m[a-z]*$/i
gb_regex = /\d+m[a-z]*$/i
attr_reader :dlspeed, :ulspeed, :dlcap, :ulcap
	def dlspeed=(dlspeed)
		case dlspeed
			when kb_regex
				@dlspeed = dlspeed.match(number_regex).to_s.to_f / 8
			when mb_regex
				@dlspeed = dlspeed.match(number_regex).to_s.to_f / 8 * 1024
			else
				raise "you didn't enter it in the correct format"
		end
	end

	def ulspeed=(ulspeed)
		case ulspeed
			when kb_regex
				@ulspeed = ulspeed.match(number_regex).to_s.to_f / 8
			when mb_regex
				@ulspeed = ulspeed.match(number_regex).to_s.to_f / 8 * 1024
			else
				raise "you didnt enter it in the correct format"
		end
	end

	def dlcap=(dlcap)
		case dlcap
			when mb_regex
				@dlcap = dlcap.match(number_regex).to_s.to_f * 1024
			when gb_regex
				@dlcap = dlcap.match(number_regex).to_s.to_f * (1024 * 1024)
			else
				raise "not right"
		end
	end

	def ulcap=(ulcap)
		case ulcap
			when mb_regex
				@ulcap = ulcap.match(number_regex).to_s.to_f * 1024
			when gb_regex
				@ulcap = ulcap.match(number_regex).to_s.to_f * (1024 * 1024)
			else
				raise "?????"
		end
	end

	def dltime
		return ((@dlcap / @dlspeed) / 60) < 1 ? (@dlcap / @dlspeed).to_s + " seconds" : ((@dlcap / @dlspeed) / 60).to_s + " minutes"
	end

	def ultime
		return ((@ulcap / @ulspeed) / 60) < 1 ? (@ulcap / @ulspeed).to_s + " seconds" : ((@ulcap / ulspeed) / 60).to_s + " minutes"
	end
end

puts "good evening friends today i will be calculatehow long it takes to reach ur dl/ul cap"
myconnection = Connection.new

puts "please enter ur download speed in either kbit or mbit in this format: 512kbit"
myconnection.dlspeed = gets.chomp

puts "ur max download speed is #{myconnection.dlspeed}kb/s right??"
puts "please enter ur download cap in either megabytes or gigabytes in this format: 10gb"
myconnection.dlcap = gets.chomp

puts "ok this how long it takes to reach ur download cap #{myconnection.dltime}!!!!!!!!!!"
puts "u wanna do upload speed too??\n(Y/N)"

abort("good night...") if gets.chomp =~ /no?$/i

puts "please enter ur upload speed in either kbit or mbit in this format: 512kbit"
myconnection.ulspeed = gets.chomp

puts "ur max upload speed is #{myconnection.ulspeed}kb/s right??"
puts "please enter ur upload cap in either megabytes or gigabytes in this format: 10gb"
myconnection.ulcap = gets.chomp

puts "download: #{myconnection.dltime}, upload: #{myconnection.ultime}.\nsad, isn't it?"
