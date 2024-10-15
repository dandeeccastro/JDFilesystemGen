require 'optparse'
require 'ostruct'
require 'yaml'

options = {}

parser = OptionParser.new do |opt|
  opt.banner = 'Usage: jd_gen [options]'
  opt.on('-s', '--source SOURCE', 'Nome do arquivo YML que servirá de base pro filesystem') { |o| options[:source] = o }
  opt.on('-d', '--destination DEST', 'Nome do diretório onde o sistema será criado') { |o| options[:dest] = o }
end

parser.parse!

if options[:source].nil? || options[:dest].nil?
  puts parser.help
  exit 1
end

data = YAML.load(File.read(options[:source]))

data.keys.each do |upper|
  `mkdir "#{options[:dest]}/#{upper}"`
  middle_values = data[upper]
  middle_values.keys.each do |middle|
    `mkdir "#{options[:dest]}/#{upper}/#{middle}"`
    final_values = data[upper][middle]
    if final_values
      final_values.keys.each do |final|
        `mkdir "#{options[:dest]}/#{upper}/#{middle}/#{final}"`
      end
    end
  end
end
