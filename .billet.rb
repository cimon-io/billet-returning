repo_root = 'https://raw.githubusercontent.com/cimon-io/billet-returning/master'
initializers_folder = File.exist?('config/initializers/monkeypatches') ? 'config/initializers/monkeypatches' : 'config/initializers'

source_file_name = case Rails::VERSION::STRING
  when "7.0.0.alpha2" then "rails_7_0_0_alpha2.rb"
  else
    raise "There are no monkeypatche available for your Rails version #{Rails::VERSION::STRING}. Please, open issue here https://github.com/cimon-io/billet-returning/issues"
end

get "#{repo_root}/#{source_file_name}", "#{initializers_folder}/active_record_database_statements.rb"
get "#{repo_root}/custom_returning_columns.rb", 'app/models/concerns/custom_returning_columns.rb'
inject_into_class "app/models/application_record.rb", "ApplicationRecord", "  extend CustomReturningColumns\n"
