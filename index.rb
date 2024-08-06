require 'optparse'
require 'ostruct'
require 'yaml'

options = {
  source_file: 'source.yml',
  dest_file: 'dest'
}
OptionParser.new do |opt|
  opt.on('-s', '--source-file SOURCEFILE', 'Nome do arquivo YML que servirá de base pro filesystem') { |o| options[:source_file] = o }
  opt.on('-d', '--destination-file DESTFILE', 'Nome do diretório onde o sistema será criado') { |o| options[:dest_file] = o }
end

data = YAML.load(File.read(options[:source_file]))

data.keys.each do |upper|
  `mkdir "#{options[:dest_file]}/#{upper}"`
  middle_values = data[upper]
  middle_values.keys.each do |middle|
    `mkdir "#{options[:dest_file]}/#{upper}/#{middle}"`
    final_values = data[upper][middle]
    if final_values
      final_values.keys.each do |final|
        `mkdir "#{options[:dest_file]}/#{upper}/#{middle}/#{final}"`
      end
    end
  end
end
