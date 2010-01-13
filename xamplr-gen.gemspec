# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{xamplr-gen}
  s.version = "1.9.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bob Hutchison"]
  s.date = %q{2010-01-13}
  s.default_executable = %q{xampl-gen}
  s.description = %q{This is the xampl code generator for Ruby.}
  s.email = %q{hutch@xampl.com}
  s.executables = ["xampl-gen"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "COPYING",
     "LICENSE",
     "Makefile",
     "README.md",
     "Rakefile",
     "VERSION",
     "bin/xampl-gen",
     "features/step_definitions/xamplr-gen_steps.rb",
     "features/support/env.rb",
     "features/xamplr-gen.feature",
     "lib/xamplr-gen.rb",
     "lib/xamplr-gen/.cvsignore",
     "lib/xamplr-gen/graphml-out.rb",
     "lib/xamplr-gen/my.gen.elements.xml",
     "lib/xamplr-gen/simpleTemplate/danger.rx",
     "lib/xamplr-gen/simpleTemplate/obsolete/input-c.r4",
     "lib/xamplr-gen/simpleTemplate/obsolete/play.r6.txt",
     "lib/xamplr-gen/simpleTemplate/obsolete/play_more.r6.txt",
     "lib/xamplr-gen/simpleTemplate/obsolete/test001.r5",
     "lib/xamplr-gen/simpleTemplate/obsolete/test002.r5",
     "lib/xamplr-gen/simpleTemplate/obsolete/test003.r5",
     "lib/xamplr-gen/simpleTemplate/old/r6.000.rb",
     "lib/xamplr-gen/simpleTemplate/old/r6.001.rb",
     "lib/xamplr-gen/simpleTemplate/play.r6",
     "lib/xamplr-gen/simpleTemplate/play_more.r6",
     "lib/xamplr-gen/simpleTemplate/play_noblanks.r6",
     "lib/xamplr-gen/simpleTemplate/playq.r6",
     "lib/xamplr-gen/simpleTemplate/r6.rb",
     "lib/xamplr-gen/simpleTemplate/simple-template.rb",
     "lib/xamplr-gen/templates/.cvsignore",
     "lib/xamplr-gen/templates/child.template",
     "lib/xamplr-gen/templates/child_indexed.template",
     "lib/xamplr-gen/templates/child_modules.template",
     "lib/xamplr-gen/templates/element_classes.template",
     "lib/xamplr-gen/templates/element_data.template",
     "lib/xamplr-gen/templates/element_empty.template",
     "lib/xamplr-gen/templates/element_mixed.template",
     "lib/xamplr-gen/templates/element_simple.template",
     "lib/xamplr-gen/templates/package.template",
     "lib/xamplr-gen/xampl-cl-gen.rb",
     "lib/xamplr-gen/xampl-generator.rb",
     "lib/xamplr-gen/xampl-hand-generated.rb",
     "lib/xamplr-gen/yuml-out.rb",
     "licence.rb",
     "test/helper.rb",
     "test/test_xamplr-gen.rb",
     "xamplr-gen.gemspec"
  ]
  s.homepage = %q{http://github.com/hutch/xamplr-gen}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{This is the xampl code generator for Ruby}
  s.test_files = [
    "test/helper.rb",
     "test/test_xamplr-gen.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_runtime_dependency(%q<xamplr>, [">= 1.9.1"])
    else
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<xamplr>, [">= 1.9.1"])
    end
  else
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<xamplr>, [">= 1.9.1"])
  end
end

