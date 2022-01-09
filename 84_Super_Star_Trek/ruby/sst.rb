# frozen_string_literal: true

Dir["app/*.rb"].each { |file| require_relative file }

galaxy = Galaxy.new

puts galaxy.hero.orders
puts 'Hit RETURN or ENTER when ready'
gets "\n"
