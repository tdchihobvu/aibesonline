class GlobalSetting < ActiveRecord::Base
  attr_accessible :config_key, :config_value

  def self.save_slideshow_image(upload)
    name =  upload['datafile'].original_filename
    directory = "public/slideshow"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end

    def self.get_config_value(key)
      c = find_by_config_key(key)
      c.nil? ? nil : c.config_value
    end

    def self.set_config_values(values_hash)
      values_hash.each_pair { |key, value| set_value(key.to_s.camelize, value) }
    end

    def self.set_value(key, value)
      config = find_by_config_key(key)
      config.nil? ?
        Configuration.create(:config_key => key, :config_value => value) :
        config.update_attribute(:config_value, value)
    end

    def self.get_multiple_configs_as_hash(keys)
      conf_hash = {}
      keys.each { |k| conf_hash[k.underscore.to_sym] = get_config_value(k) }
      conf_hash
    end

end
