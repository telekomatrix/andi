# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{andi}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Britt / Neurogami"]
  s.date = %q{2009-09-19}
  s.default_executable = %q{andi}
  s.description = %q{}
  s.email = %q{james@neurogami.com}
  s.executables = ["andi"]
  s.extra_rdoc_files = ["History.txt", "__WE_ARE_USING_TICGIT_HERE.txt", "bin/andi"]
  s.files = [".ghcache/issues.yaml", ".ghissues", "History.txt", "NOTES.md", "README.markdown", "Rakefile", "__WE_ARE_USING_TICGIT_HERE.txt", "bin/andi", "lib/andi.rb", "lib/andi/andi.rb", "spec/andi_spec.rb", "spec/spec_helper.rb", "test/test_andi.rb"]
  s.homepage = %q{http://github.com/neurogami/andi}
  s.rdoc_options = ["--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{there-is-no-rubyforge-project}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Tool for android development}
  s.test_files = ["test/test_andi.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bones>, [">= 2.5.0"])
    else
      s.add_dependency(%q<bones>, [">= 2.5.0"])
    end
  else
    s.add_dependency(%q<bones>, [">= 2.5.0"])
  end
end
