class Git

    require 'git'
    require 'date'
    require 'fileutils'

    def initialize(url="",forced=false,ver="")

	@url = url

	@name = @url.gsub(/^(https:\/\/|http:\/\/)/,'').split('/')[2]

	@forced = forced

	@ver = ver

    end

    def git()

	Git.clone(@url, @name)

	g = Git.open(@name)

	date = Time.now.strftime("%Y%m%d")

	rev = g.log.last.to_s[0..6]

	if @forced then

		@v = @ver

	else

		@v = "0.0.0"

	end

	version = @v + "+git" + date + "." + rev

 	FileUtils.mv(@name,"#{@name}-#{version}")

	xzip("#{@name}-#{version}")

	source = "#{@name}-%{version}.tar.xz"

	writeservice()

	writechanges()

	return version,source

    end

    def writeservice()

	open("./template.service.in",'r') do |f|

	#TODO LACK pkgname, need a new module	

	end	

    end

    def writechanges()

	# TODO
	return nil

    end

    def xzip(filename="")

        system "tar -cf #{filename}.tar #{filename}"

        system "xz -z -9 #{filename}.tar"

    end

end
