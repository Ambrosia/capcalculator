#!/usr/bin/env ruby

def mbit_to_kbit(speed)
	return speed * 1024
end

def bit_to_byte(bits)
	return bits / 8
end

def megabytes_to_kilobytes(mb)
	return mb * 1024
end

def gigabytes_to_kilobytes(gb)
	return megabytes_to_kilobytes(gb * 1024)
end

def seconds_to_minutes(sec)
	return sec / 60
end

puts "good evening friends this is ambrosia and today i will be calculatehow long it takes to reach ur dl/ul cap"
puts "u wanna enter ur dl speed in kilobits/sec or megabits/sec?\n(K/M)"

case gets.chomp
	when /^k\w*/i
		puts "enter ur dl speed in kilobits"
		dlspeed = bit_to_byte(Float(gets.chomp))
	when /^m\w*/i
		#converts megabit to kilobits (e.g. 10mbit to 10240kbit) then kilobits to kilobytes (e.g. 10240kbites to 1280kbytes)
		puts "enter ur dl speed in megabits"
		dlspeed = bit_to_byte(mbit_to_kbit(Float(gets.chomp)))
	else
		puts "start again, idiot."
		exit
end

puts "ur max download speed is #{dlspeed}kb/s right??"
puts "would u like to enter ur download cap megabytes or gigabytes??\n(M/G)"

case gets.chomp
	when /^m\w*/i
		puts "please enter ur cap in megabytes"
		dlcap = megabytes_to_kilobytes(Float(gets.chomp))
	when /^g\w*/i
		puts "please entr ur cap in gigabytes"
		dlcap = gigabytes_to_kilobytes(Float(gets.chomp))
	else
		puts "and u tried so hard..."
		exit
end

seconds_to_minutes(dlcap / dlspeed) < 1 ? dlresult = (dlcap/dlspeed).to_s + " seconds" : dlresult = seconds_to_minutes(dlcap / dlspeed).to_s + " minutes"

puts "ok this how long it takes to reach ur download cap #{dlresult}!!!!!!!!!!"
puts "u wanna do upload speed too??\n(Y/N)"

abort("good night...") if gets.chomp =~ /no?$/i

puts "u wanna enter ur ul speed in kilobits/sec or megabits/sec?\n(K/M)"

case gets.chomp
	when /^k\w*/i
		puts "enter ur ul speed in kilobits"
		ulspeed = bit_to_byte(Float(gets.chomp))
	when /^m\w*/i
		puts "enter ur ul speed in megabits"
		ulspeed = bit_to_byte(mbit_to_kbit(Float(gets.chomp)))
	else
		puts "start again, idiot."
		exit
end

puts "ur max upload speed is #{ulspeed}kb/s right??"
puts "would u like to enter ur upload cap megabytes or gigabytes??\n(M/G)"

case gets.chomp
	when /^m\w*/i
		puts "please enter ur cap in megabytes"
		ulcap = megabytes_to_kilobytes(Float(gets.chomp))
	when /^g\w*/i
		puts "please entr ur cap in gigabytes"
		ulcap = gigabytes_to_kilobytes(Float(gets.chomp))
	else
		puts "and u tried so hard..."
		exit
end

if seconds_to_minutes(dlcap / dlspeed) < 1
	ulresult = (ulcap/ulspeed).to_s + " seconds"
elsif
	ulresult = seconds_to_minutes(dlcap / dlspeed).to_s + " minutes"
end

puts "download: #{dlresult}, upload: #{ulresult}.\nsad, isn't it?"
