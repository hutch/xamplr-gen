require 'optparse'

include XamplGenerator
include Xampl

class ProjectGenerator

  def initialize(specialised=true)
    @specialised = specialised
  end

  def directory
    File.join(%w{ . xampl-generated-code })
  end

  def filenames
    Dir.glob("./xml/**/*.xml")
  end

  def print_base_filename
    #File.join(%w{ . generated })
    'generated'
  end

  def print_options
    # return an array containing any (or none) of:
    #    :schema    -- a schema-like xml representation of the generated code
    #    :graphml   -- a graphml file describing the class model (compatible with yEd)
    #    :yuml      -- a yuml file that represents a simplified class model (compatible with yUML)

    # [:schema, :graphml, :yuml]
    []
  end

  def print
    nil
  end

  def persisted_attributes
    %w{ pid }
  end

  def indexed_attributes
    %w{ id }
  end

  def resolve_namespaces
    # any array of arrays
    # each sub-array:
    #    0: a string or an array of strings, containing xml namespaces found in the example xml files
    #       an empty string is the default namespace
    #    1: a ruby Module name (get the cases right)
    #    2: a namespace prefix used when writing xml, optional. A generated prefix will be used otherwise.
    []
  end

  @@specialisation_file_content = <<_EOF_
class ProjectGenerator

  def print_options
    # return an array containing any (or none) of:
    #    :schema    -- a schema-like xml representation of the generated code
    #    :graphml   -- a graphml file describing the class model (compatible with yEd)
    #    :yuml      -- a yuml file that represents a simplified class model (compatible with yUML)

    [ :yuml ]
  end

  def directory
    # return the path name to the generator's output directory
    File.join(%w{ . xampl-generated-code })
  end

  def resolve_namespaces
    # any array of arrays
    # each sub-array:
    #    0: a string or an array of strings, containing xml namespaces found
    #       in the example xml files an empty string is the default namespace
    #    1: a ruby Module name (get the character cases right)
    #    2: a namespace prefix used when writing xml, optional. A generated
    #       prefix will be used otherwise.

    [
{{MAPPING}}
    ]
  end
end
_EOF_

  def write_specialisation_file(element_map)
    filename = './project-generator.rb'
    return if File.exists? filename

    mappings = []
    count = 0
    element_map.each do | ns, elements |
      module_name = elements.element.first.package || 'XamplAdHoc'
      count += 1
      mappings << [ ns, module_name, "ns#{ count }" ]
    end

    text =  @@specialisation_file_content.gsub(/{{MAPPING}}/) do
      insert = []
      mappings.each do | ns, module_name, prefix |
        insert << "            ['#{ ns }', '#{ module_name }', '#{ prefix }'],"
      end
      insert.join("\n")
    end

    File.open(filename, 'w') do | out |
      out.write text
    end
  end

  def generate

    cl_options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: junk.rb [options]"

      opts.on("--download-yuml-png [FILENAME]", "Download the yuml png file if possible.") do | filename |
        cl_options[:download_yuml_png] = filename || true
      end
      opts.on("--download-yuml-pdf [FILENAME]", "Download the yuml pdf file if possible.") do | filename |
        cl_options[:download_yuml_pdf] = filename || true
      end
    end.parse!

#      Xampl.set_default_persister_kind(:simple)
    Xampl.set_default_persister_kind(:in_memory)
#      Xampl.set_default_persister_kind(:filesystem)
#      Xampl.set_default_persister_kind(:tokyo_cabinet)
#      Xampl.set_default_persister_format(:xml_format)

    dirname = self.directory
    
=begin

    if File.directory? dirname then
      begin
        FileUtils.rm_rf([ dirname ])
      rescue => e
        puts "could not clean up #{ dirname } -- #{ e }"
        return
      end
    elsif File.exists? dirname then
      puts "please move #{ dirname } out of the way of xampl-gen"
      return
    end

=end

    Xampl.transaction("project-generation") do

      options = Options.new do | opts |
        persisted_attributes.each do | pattr |
          opts.new_index_attribute(pattr).persisted = true
        end

        indexed_attributes.each do | iattr |
          opts.new_index_attribute(iattr)
        end

        resolve_namespaces.each do | namespace, ruby_module_name, output_ns_prefix |
          opts.resolve(namespace, ruby_module_name, output_ns_prefix)
        end

      end

      generator = Generator.new('generator')
      okay = generator.go(:options => options,
                          :filenames => filenames,
                          :directory => directory)

      if okay
        puts generator.print_elements("#{ directory }/#{ print_base_filename }", print_options)
        self.write_specialisation_file(generator.elements_map)

        generated_files = Dir.glob("#{ self.directory }/*.rb")
        if 0 < generated_files.size then
          all = []
          #abs = []
          generated_files.each do | filename |
            all << "require \"\#\{ File.dirname __FILE__ \}/#{ File.basename(filename, '.rb') }\""
            #all << "require '#{ File.dirname(filename)[2..-1] }/#{ File.basename(filename, '.rb') }'"
            #abs_filename = File.expand_path(filename)
            #abs << "require '#{ File.dirname(abs_filename) }/#{ File.basename(abs_filename, '.rb') }'"
          end

          out_filename = "#{ self.directory }/all.rb"
          File.open(out_filename, 'w') do | out |
            out.puts all.join("\n")
          end
          puts "WRITE TO FILE: #{ out_filename }"

          #out_filename = "#{ self.directory }/all-absolute.rb"
          #File.open(out_filename, 'w') do | out |
          #  out.puts abs.join("\n")
          #end
          #puts "WRITE TO FILE: #{ out_filename }"

          if File.exists?("#{ self.directory }/generated.yuml") && (cl_options[:download_yuml_png] || cl_options[:download_yuml_pdf]) then
            diagram = ""
            File.open("#{ self.directory }/generated.yuml") do | f |
              f.each do | line |
                diagram << line.chomp
              end
            end

            okay = false
            if cl_options[:download_yuml_png] then
              begin
                filename = (true == cl_options[:download_yuml_png]) ?  'generated.png' : cl_options[:download_yuml_png]
                wget = "wget 'http://yuml.me/diagram/scruffy/class/#{diagram}' -O '#{ self.directory }/#{filename}'"
                okay = system(wget)
                if okay then
                  puts "downloaded yuml png"
                else
                  puts "could not get the yuml png file -- #{ $? }"
                end
              rescue => e
                puts "could not get the yuml png file -- #{ e }"
              end
            end

            if cl_options[:download_yuml_pdf] then
              begin
                filename = (true == cl_options[:download_yuml_png]) ?  'generated.png' : cl_options[:download_yuml_png]
                wget = "wget 'http://yuml.me/diagram/scruffy/class/#{diagram}.pdf' -O '#{filename}'"
                okay = system(wget)
                puts "downloaded yuml pdf"
                if okay then
                  puts "downloaded yuml pdf"
                else
                  puts "could not get the yuml pdf file -- #{ $? }"
                end
              rescue => e
                puts "could not get the yuml pdf file -- #{ e }"
              end
            end
          end
        end
      end
      Xampl.rollback

    end
  end
end

