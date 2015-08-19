class Opts

    require 'optparse'
    
    def initialize(options={})

	OptionParser.new do |opts|
	
		opts.banner = "Usage: go2rpm [options]"

		opts.on('-p', '--path IMPORTPATH', 'IMPORTPATH') { |v|
			options[:importpath] = v }

		opts.on('-u', '--url url', 'Upstream URL') { |v|
			options[:url] = v }

		opts.on('-n', '--name pkgname', 'Package Name') { |v|
			options[:pkgname] = v }
		
		opts.on('-v', '--version version', 'Package Version') { |v|
			options[:version] = v }

		opts.on('-s', '--source tarball', 'Source') { |v|
			options[:source] = v }

		opts.on('-f', '--force-git', 'Force git version even there\'s releases') { |v|
			options[:forcegit] = v }

	end.parse!
        
	if options[:url] then

		unless options[:importpath] then

			options[:importpath] = options[:url].gsub(/^(https:\/\/|http:\/\/)/,'')

		end

		array = options[:importpath].split("/")

		website = array[0].gsub(/(\.com|\.org|\.net|\.in)/,'') # to enhance

		author = array[1]

		name = array[2]

		unless options[:pkgname] then

			options[:pkgname] = "golang-#{website}-#{author}-#{name}"

		end

	else

		raise "URL is empty, please specify with -u."

	end

	return options

    end

end