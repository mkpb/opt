require "mkpb/opt/version"
require "getoptlong"

module Mkpb
  module Opt

	class GetoptLong
       		def to_h
                	ret = {}
                	self.each {|k,v| ret[k.gsub(/^-+/,"").to_sym]=v }
                	ret
        	end
	end

	class Opt < GetoptLong

        	@h = {required: GetoptLong::REQUIRED_ARGUMENT, no: GetoptLong::NO_ARGUMENT, optional: GetoptLong::OPTIONAL_ARGUMENT, mandatory: GetoptLong::REQUIRED_ARGUMENT}

        	def self.get(*ar)
               		ret = GetoptLong.new(*ar.map{|x| x.map { |e| @h[e] ? @h[e] : e }}).to_h

                	ar.inject([]) {|r,n| r << n.first.gsub(/^-+/,"").to_sym if n.last==:mandatory; r}.each do |mandatory_field|
                        	begin   
                                	puts "please provide --#{mandatory_field} parameter"
                                	exit(1)
                        	end if not ret[mandatory_field]

                	end

                	ret
        	end
	end

  end
end
