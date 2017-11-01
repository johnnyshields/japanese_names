# frozen_string_literal: true

namespace :enamdict do
  TMP_FILE = 'tmp/enamdict'.freeze

  desc 'Downloads and compacts the ENAMDICT file'
  task refresh: %w[download minify]

  desc 'Downloads and extracts ENAMDICT file from ftp.monash.edu.au to /tmp/enamdict'
  task :download do
    require 'fileutils'
    require 'open-uri'
    require 'zlib'

    puts 'Downloading ENAMDICT...'

    FileUtils.mkdir_p 'tmp'
    uri = 'http://ftp.monash.edu/pub/nihongo/enamdict.gz'
    f = File.open(TMP_FILE, 'w')
    f.write(Zlib::GzipReader.open(open(uri)).read)
    f.close

    puts "Downloaded to #{loc}"
  end

  # Minification steps:
  # - Encode file as UTF-8 (increases size by ~25%)
  # - Filter out non-human name dictionary entries
  # - Remove Romaji from string (redundant with kana)
  # - Uses pipe '|' char as delimiter
  # - Sets kana value to kanji value if kana not specified (increases size by ~10%)
  # - Output file is approx 40% of original filesize
  #
  # Format of minified file:
  #
  #   kanji|kana|flag1(,flag2,...)
  #
  desc 'Compacts ENAMDICT file at /bin/enamdict.min'
  task :minify do
    puts 'Minifying ENAMDICT...'

    # TODO: load this from main library
    name_types = %w[s p u g f m]
    skip_types = %w[h]

    i = 0
    j = 0
    out = File.open('bin/enamdict.min', 'w:utf-8')
    File.open(TMP_FILE, 'r:euc-jp') do |f|
      f.gets # skip header
      while (line = f.gets) != nil
        data = line.scan(%r{^(.+?) (?:\[(.+?)\] )?/\((.+?)\).+/$})[0]
        next unless data
        data[1] ||= data[0]
        data_types = data[2].split(',')
        if (data_types & name_types).any? && !(data_types & skip_types).any? && !(%w[p u].include?(data[2]) && data[0].encode('utf-8') =~ /\p{Katakana}/)
          out.puts(data.join('|'))
          j += 1
        end
        i += 1
      end
    end
    out.close

    puts "Minified! (#{j} out of #{i} lines kept)"
  end
end
