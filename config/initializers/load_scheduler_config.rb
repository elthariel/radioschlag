raw_config = File.read(RAILS_ROOT + "/config/scheduler_config.yml")
SCHEDULER_CONFIG = YAML.load(raw_config)[RAILS_ENV].symbolize_keys
