puts 'Empty the MongoDB database, exclude System stuff'

Mongoid.master.collections.select do |collection|
      include = collection.name !~ /system/
      puts 'Dropping ' + collection.name if include
      include
    end.each(&:drop)