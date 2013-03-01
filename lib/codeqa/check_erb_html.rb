require 'codeqa/fake_erb'
require 'open3'
module Codeqa
  class CheckErbHtml < Checker
    def self.check?(sourcefile)
      sourcefile.attributes['language']=='html'
    end

    def name
      "erb html"
    end

    def hint
      "The html I see after removing the erb stuff is not valid (find the unclosed tags and attributes)."
    end
    def check
      html=FakeERB.new(sourcefile.content).result
      result = nil

      with_existing_file(html) do |filename|
        Open3.popen3("tidy -q -e -xml '#{filename}'") do |in_stream, out_stream, err_stream|
          message=err_stream.read;
          result=message if message =~ /(Error:|missing trailing quote|end of file while parsing attributes)/m
        end # IO.popen
      end #Tempfile

      if result
        errors.add(nil, html)
        errors.add(nil, result)
      end

    end
  end
end

Codeqa::Runner.register_checker(Codeqa::CheckErbHtml)