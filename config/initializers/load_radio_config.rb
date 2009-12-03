raw_config = File.read(RAILS_ROOT + "/config/radio_config.yml")
RADIO_CONFIG = YAML.load(raw_config)[RAILS_ENV].symbolize_keys
