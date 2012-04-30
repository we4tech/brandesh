namespace :importer do
  desc 'Import category'
  task :categories => :environment do
    Category.destroy_all

    lines = File.read(Rails.root.join('categories.txt')).lines.entries
    root = Category.create(name: 'root')

    lines.each_with_index do |line, index|
      if line.match(/^\d{2}\.\s*/)
        name = line.strip.gsub(/^\d{2}\.\s*/, '')
        description = lines[index + 1].strip.gsub(/>>\s*/, '')
        puts "n: #{name}"
        puts "d: #{description}"
        root.categories << Category.new(name: name, description: description)
      end
    end

    puts "Total - #{Category.count} categories created."
  end

  desc 'Import media types'
  task :media_types => :environment do
    types = [ 'TV', 'Print', 'Radio', 'Outdoor', 'New Media' ]
    Category.where(:name => 'media_root').destroy_all

    root = Category.create(:name => 'media_root')
    types.each {|t| root.categories << Category.new(name: t)}

    puts "Total - #{types.length} media types added."
  end
end