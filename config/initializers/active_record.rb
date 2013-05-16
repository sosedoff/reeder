ActiveRecord::Base.establish_connection(
  YAML.load_file('config/database.yml')[ENV['RACK_ENV']]
)

ActiveRecord::Base.include_root_in_json = false