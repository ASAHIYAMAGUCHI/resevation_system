puts "=== Seeding start ==="

Dir[File.join(__dir__, "seeds", "*.rb")].sort.each do |file|
  load file
end

puts "=== Seeding complete! ==="
