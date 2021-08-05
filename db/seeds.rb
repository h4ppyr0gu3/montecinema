# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def seed_cinema rows, columns, cinema_number
	for i in 1..columns do 
		for j in 1..rows do
			seat_letter = "a".ord + (i - 1)
			seat_letter = seat_letter.chr
			seat_number = seat_letter + "-" + j.to_s
			seat = Seat.new(cinema_number: cinema_number, seat_number: seat_number)
			if seat.save
				puts "cinema_number: " + cinema_number.to_s + ", seat_number: " + seat_number
			else
				if seat.errors.any?
					puts seat.errors.messages
				end
			end
		end
	end
end

cinemas = [
[10, 20, 1],
[10, 10, 2],
[10, 10, 3],
[10, 10, 4],
[10, 10, 5],
[5, 10, 6],
[5, 10, 7],
[5, 10, 8],
[5, 10, 9],
[5, 4, 10]
]

cinemas.each do |cinema|
	seed_cinema(cinema[0], cinema[1], cinema[2])
end