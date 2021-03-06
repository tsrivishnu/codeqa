Codeqa.configure do |config|
  config.excludes = ['spec/fixtures/html_error.html.erb',
                     'spec/fixtures/html_error.text.html',
                     'spec/fixtures/ruby_error.rb',
                     'lib/codeqa/checkers/check_pry.rb',
                     'spec/lib/codeqa/checkers/check_pry_spec.rb',
                     'spec/lib/codeqa/checkers/check_rspec_focus_spec.rb',
                     'coverage/*',
                     'pkg/*']

  config.enabled_checker.delete 'CheckRubySyntax'
  config.enabled_checker << 'Rubocop'
end
