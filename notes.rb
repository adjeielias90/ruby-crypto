require 'ascii_charts'

cornell_src = {
  "E" => 12.02,
  "T" => 9.10,
  "A" => 8.12,
  "O" => 7.68,
  "I" => 7.31,
  "N" => 6.95,
  "S" => 6.28,
  "R" => 6.02,
  "H" => 5.92,
  "D" => 4.32,
  "L" => 3.98,
  "U" => 2.88,
  "C" => 2.71,
  "M" => 2.61,
  "F" => 2.30,
  "Y" => 2.11,
  "W" => 2.09,
  "G" => 2.03,
  "P" => 1.82,
  "B" => 1.49,
  "V" => 1.11,
  "K" => 0.69,
  "X" => 0.17,
  "Q" => 0.11,
  "J" => 0.10,
  "Z" => 0.07
}

robert_lewand_src = {
  "E" => 12.702,
  "T" => 9.056,
  "A" => 8.167,
  "O" => 7.507,
  "I" => 6.966,
  "N" => 6.749,
  "S" => 6.327,
  "H" => 6.094,
  "R" => 5.987,
  "D" => 4.253,
  "L" => 4.025,
  "C" => 2.782,
  "U" => 2.758,
  "M" => 2.406,
  "W" => 2.36,
  "F" => 2.228,
  "G" => 2.015,
  "Y" => 1.974,
  "P" => 1.929,
  "B" => 1.492,
  "V" => 0.978,
  "K" => 0.772,
  "J" => 0.153,
  "X" => 0.15,
  "Q" => 0.095,
  "Z" => 0.074
}

frankenstein_src = {
  "P" => 1.76,
  "R" => 5.99,
  "O" => 7.26,
  "J" => 0.14,
  "E" => 13.24,
  "C" => 2.66,
  "T" => 8.73,
  "G" => 1.72,
  "U" => 2.99,
  "N" => 7.01,
  "B" => 1.45,
  "S" => 6.09,
  "F" => 2.51,
  "A" => 7.69,
  "K" => 0.5,
  "I" => 7.08,
  "Y" => 2.28,
  "M" => 3.05,
  "W" => 2.2,
  "L" => 3.66,
  "D" => 4.85,
  "H" => 5.67,
  "V" => 1.1,
  "Z" => 0.07,
  "X" => 0.19,
  "Q" => 0.09
}

# ASCII histograms of letter frequencies
[{ "Cornell data" => cornell_src }, { "Robert Lewand data" => robert_lewand_src }, { "Frankenstein data" => frankenstein_src }].each do |dataset|
  puts AsciiCharts::Cartesian.new(dataset.values[0], :bar => true, :hide_zero => true, :title => "#{dataset.keys[0]}" ).draw
end

# cornell_src = [["E", 12.02], ["T", 9.1], ["A", 8.12], ["O", 7.68], ["I", 7.31], ["N", 6.95], ["S", 6.28], ["R", 6.02], ["H", 5.92], ["D", 4.32], ["L", 3.98], ["U", 2.88], ["C", 2.71], ["M", 2.61], ["F", 2.3], ["Y", 2.11], ["W", 2.09], ["G", 2.03], ["P", 1.82], ["B", 1.49], ["V", 1.11], ["K", 0.69], ["X", 0.17], ["Q", 0.11], ["J", 0.1], ["Z", 0.07]]
# robert_lewand_src = [["E", 12.702], ["T", 9.056], ["A", 8.167], ["O", 7.507], ["I", 6.966], ["N", 6.749], ["S", 6.327], ["H", 6.094], ["R", 5.987], ["D", 4.253], ["L", 4.025], ["C", 2.782], ["U", 2.758], ["M", 2.406], ["W", 2.36], ["F", 2.228], ["G", 2.015], ["Y", 1.974], ["P", 1.929], ["B", 1.492], ["V", 0.978], ["K", 0.772], ["J", 0.153], ["X", 0.15], ["Q", 0.095], ["Z", 0.074]]
# frankenstein_src = [["E", 13.24], ["T", 8.73], ["A", 7.69], ["O", 7.26], ["I", 7.08], ["N", 7.01], ["S", 6.09], ["R", 5.99], ["H", 5.67], ["D", 4.85], ["L", 3.66], ["M", 3.05], ["U", 2.99], ["C", 2.66], ["F", 2.51], ["Y", 2.28], ["W", 2.2], ["P", 1.76], ["G", 1.72], ["B", 1.45], ["V", 1.1], ["K", 0.5], ["X", 0.19], ["J", 0.14], ["Q", 0.09], ["Z", 0.07]]

cornell_src = cornell_src.sort_by { |k,v| v }.reverse
robert_lewand_src = robert_lewand_src.sort_by { |k,v| v }.reverse
frankenstein_src = frankenstein_src.sort_by { |k,v| v }.reverse

# cornell_src.zip(robert_lewand_src) { |a,b| puts "#{a[0]} cornell_src, robert_lewand_src: #{a[1]}, #{b[1]}, std dev #{(a[1]-b[1]).abs.round(3)}" }
# cornell_src.zip(frankenstein_src) { |a,b| puts "#{a[0]} cornell_src, frankenstein_src: #{a[1]}, #{b[1]}, std dev #{(a[1]-b[1]).abs.round(3)}" }
# robert_lewand_src.zip(frankenstein_src) { |a,b| puts "#{a[0]} robert_lewand_src, frankenstein_src: #{a[1]}, #{b[1]}, std dev #{(a[1]-b[1]).abs.round(3)}" }

cr_standard_deviations = Hash.new(0); cornell_src.zip(robert_lewand_src) { |a,b| cr_standard_deviations[a[0]] = (a[1]-b[1]).abs.round(3) }
cf_standard_deviations = Hash.new(0); cornell_src.zip(frankenstein_src) { |a,b| cf_standard_deviations[a[0]] = (a[1]-b[1]).abs.round(3) }
wf_standard_deviations = Hash.new(0); robert_lewand_src.zip(frankenstein_src) { |a,b| wf_standard_deviations[a[0]] = (a[1]-b[1]).abs.round(3) }
standard_deviations = cr_standard_deviations.merge(cf_standard_deviations) { |key, oldval, newval| [oldval, newval].max } \
                                            .merge(wf_standard_deviations) { |key, oldval, newval| [oldval, newval].max }

safe_standard_deviations = Hash.new(0)
standard_deviations.each { |k,v| safe_standard_deviations[k] = (standard_deviations[k] + 0.1).round(3) }
