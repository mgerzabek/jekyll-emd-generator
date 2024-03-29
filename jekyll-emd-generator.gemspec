require_relative 'lib/jekyll-emd-generator/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-emd-generator"
  spec.version       = EnhanceMetaData::Generator::VERSION
  spec.authors       = ["Michael Gerzabek"]
  spec.email         = ["michael.gerzabek@gmail.com"]

  spec.summary       = "A Jekyll plugin to add metadata to the frontmatter of individual pages."
  spec.homepage      = "https://github.com/mgerzabek/jekyll-emd-generator"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/mgerzabek/jekyll-emd-generator/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do 
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency "jekyll", ">= 3.8", "< 5.0"
  spec.add_dependency "fastimage", ">=2.2.0", "< 3.0"
end
