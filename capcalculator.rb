#!/usr/bin/env ruby

class Connection
#store everything in kilobytes
#ok maybe im going a little overboard on this part
@@number_regex = /^[\d.?]+/
@@kb_regex = /\d+k[a-z]*$/i
@@mb_regex = /\d+m[a-z]*$/i
@@gb_regex = /\d+g[a-z]*$/i
@@percent_regex = /%$/

attr_reader :dlspdmax, :ulspdmax, :dlcap, :ulcap, :dlspdcur, :ulspdcur
	def dlspdmax=(dlspdmax)
		case dlspdmax
			when @@kb_regex
				@dlspdmax = dlspdmax.match(@@number_regex).to_s.to_f / 8
			when @@mb_regex
				@dlspdmax = dlspdmax.match(@@number_regex).to_s.to_f / 8 * 1024
			else
				raise "you didn't enter it in the correct format"
		end
		@dlspdcur = 1
	end

	def ulspdmax=(ulspdmax)
		case ulspdmax
			when @@kb_regex
				@ulspdmax = ulspdmax.match(@@number_regex).to_s.to_f / 8
			when @@mb_regex
				@ulspdmax = ulspdmax.match(@@number_regex).to_s.to_f / 8 * 1024
			else
				raise "you didnt enter it in the correct format"
		end
		@ulspdcur = 1
	end

	def dlcap=(dlcap)
		case dlcap
			when @@mb_regex
				@dlcap = dlcap.match(@@number_regex).to_s.to_f * 1024
			when @@gb_regex
				@dlcap = dlcap.match(@@number_regex).to_s.to_f * (1024 * 1024)
			else
				raise "not right"
		end
	end

	def ulcap=(ulcap)
		case ulcap
			when @@mb_regex
				@ulcap = ulcap.match(@@number_regex).to_s.to_f * 1024
			when @@gb_regex
				@ulcap = ulcap.match(@@number_regex).to_s.to_f * (1024 * 1024)
			else
				raise "?????"
		end
	end

	def dltime
		return ((@dlcap / @dlspdmax) / 60) < 1 ? (@dlcap / @dlspdmax).to_s * @dlspdcur + " seconds" : ((@dlcap / @dlspdmax) / 60).to_s + " minutes"
	end

	def ultime
		return ((@ulcap / @ulspdmax) / 60) < 1 ? (@ulcap / @ulspdmax).to_s * @ulspdcur + " seconds" : ((@ulcap / @ulspdmax) / 60).to_s + " minutes"
	end

	def dlspdcur=(dlspdcur)
		case dlspdcur
			when @@percent_regex
				@dlspdcur = dlspdcur.match(@@number_regex).to_s.to_f / 100
			when @@kb_regex
				@dlspdcur = dlspdcur.match(@@number_regex).to_s.to_f / @dlspdmax
			when @@number_regex
				@dlspdcur = dlspdcur.match(@@number_regex).to_s.to_f
				raise RangeError, "you entered a number higher than 1 that wasn't a transfer speed or percentage" if @dlspdcur > 1
			else
				raise "this exception is not helpful"
		end
	end

	def ulspdcur=(ulspdcur)
		case ulspdcur
			when @@percent_regex
				@ulspdcur = ulspdcur.match(@@number_regex).to_s.to_f / 100
			when @@kb_regex
				@ulspdcur = ulspdcur.match(@@number_regex).to_s.to_f / @ulspdmax
			when @@number_regex
				@ulspdcur = ulspdcur.match(@@number_regex).to_s.to_f
				raise RangeError, "you entered a number higher than 1 that wasn't a transfer speed or percentage" if @ulspdcur > 1
			else
				raise "why"
		end
	end
end

puts "good evening friends today i will be calculatehow long it takes to reach ur dl/ul cap"
myc = Connection.new

puts "please enter ur download speed in either kbit or mbit in this format: 512kbit"
myc.dlspdmax = gets.chomp

puts "ur max download speed is #{myc.dlspdmax}kb/s right??"
puts "please enter ur download cap in either megabytes or gigabytes in this format: 10gb"
myc.dlcap = gets.chomp

puts "are you downloading at max speed or not? enter either your speed in kilobytes per second, percentage of max speed or a number between 0 and 1 (enter 1 if you are at max speed)"
myc.dlspdcur = gets.chomp

puts "ok this how long it takes to reach ur download cap #{myc.dltime} at #{myc.dlspdmax * myc.dlspdcur}kb/s!!!!!!!!!!"
puts "u wanna do upload speed too??\n(Y/N)"

abort("good night...") if gets.chomp =~ /no?$/i

puts "please enter ur upload speed in either kbit or mbit in this format: 512kbit"
myc.ulspdmax = gets.chomp

puts "ur max upload speed is #{myc.ulspdmax}kb/s right??"
puts "please enter ur upload cap in either megabytes or gigabytes in this format: 10gb"
myc.ulcap = gets.chomp

puts "are you uploading at max speed or not? enter either your speed in kilobytes per second, percentage of max speed or a number between 0 and 1 (enter 1 if you are at max speed)"
myc.ulspdcur = gets.chomp

puts "download: #{myc.dltime} @ #{myc.dlspdmax * myc.dlspdcur}kb/s, upload: #{myc.ultime} @ #{myc.ulspdmax * myc.ulspdcur}kb/s.\nsad, isn't it?"
