class Dotenv
  class << self
    attr_accessor :overload

    def read(*filenames)
      config = filenames.reduce({}) { |acc, filename| acc.merge(_read(filename)) }

      Dotenv.new(config, overload: overload)
    end

    private

    def _read(filename)
      config_map = {}

      return config_map unless File.exist?(filename)

      File.foreach(filename) do |line|
        pairs = line.strip.split('=')
        pairs << '' if pairs.length < 2

        config_map[pairs[0]] = pairs[1]
      end

      config_map
    end
  end

  def initialize(config = {}, overload: false)
    @map = config

    populate_env(@map) if overload
  end

  def fetch(key)
    env_value = ENV[key]
    config_value = @map[key]

    ENV[key] = config_value if @overload && config_value.present?

    return env_value unless config_value.present?

    config_value
  end

  private

  def populate_env(config = {})
    config.each do |k, v|
      ENV["#{k}_OLD"] = ENV[k]
      ENV[k] = v
    end
  end
end

