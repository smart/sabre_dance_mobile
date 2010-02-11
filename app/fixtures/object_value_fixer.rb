file = File.read('object_values.txt')
new_file = File.open('new_object_values.txt', "w")

file.each do |line|
  buffer ||= ""
  buffer += line
  if line[-2,1] == "|"
    p "writing #{buffer}"
    new_file.write(buffer)
    buffer = ""
  end

end
file.close
new_file.close