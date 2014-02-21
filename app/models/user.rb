require 'digest/sha1'
class User < ActiveRecord::Base
  attr_accessible :name, :mobile_number, :email, :password_confirmation, :password

  validates :name,  :presence => true, :on => :create
  validates :email, :uniqueness => true, :presence => true, 
            :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
            :on => :create }
  validates :mobile_number, :numericality => true, :on => :create
  validates :password, :confirmation => true, :presence => true

  validate :mobile_number_non_blank, :on => :create
  validate :mobile_number_invalid, :on => :create
  validate :password_non_blank

  

  def role_symbols
    if manager?
    return [:manager]
     elsif registered?
      return [:registered]
    end
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.encrypted_password = User.password_enycrypted(self.password, self.salt)
  end
  
  # Generates a random string from a set of easily readable characters
  def self.generate_activation_code(size = 8)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

  def self.authenticate(email, password)
    user = self.find_by_email_and_is_active_and_registered(email, true, true)
      if user
        expected_password = password_enycrypted(password, user.salt)
        if user.encrypted_password != expected_password
        user = nil
      end
      end
      user
  end

  def self.renew_access_token(email)
    user = self.find_by_email(email)
    unless user.nil?
      user
    end
  end

  def self.authenticate_manager(random_pass, mobile_number)
    user = self.find_by_random_pass_and_is_active_and_manager(random_pass, true, true)
      if user
        expected_mobile_number = encrypted_mobile_number(mobile_number, user.salt)
      if user.phone_number != expected_mobile_number
        user = nil
      end
      end
      user
  end

  def self.activate_user_account(user_code)
    user = self.find_by_phone_number(user_code)
    user.update_attribute(:is_active, true)
    user.update_attribute(:registered, true)
  end

  def mobile_number
    @mobile_number
  end

  def mobile_number=(mob)
    @mobile_number = mob
    return if mob.blank?
    create_new_salt
    self.reset_password_token = User.generated_password_reset_token
    self.phone_number = User.encrypted_mobile_number(self.mobile_number, self.salt)
  end


  private

  def password_non_blank
    errors.add(:password, "missing.") if encrypted_password.blank?
  end
  
  def mobile_number_non_blank
    errors.add(:mobile_number, "missing") if phone_number.blank?
  end

  def mobile_number_invalid
    config = GlobalSetting.find_by_config_key("AllowedMobile")
    config1 = GlobalSetting.find_by_config_key("AllowedMobileDigits")
    errors.add(:mobile_number, "is invalid") if mobile_number.first(3) != "#{config.config_value}" || mobile_number.length != 10
  end

  def self.encrypted_mobile_number(mobile_number, salt)
    string_to_hash = mobile_number + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def self.password_enycrypted(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.generated_password_reset_token
    reset_token = self.object_id.to_s + rand.to_s + self.generate_activation_code
    Digest::SHA1.hexdigest(reset_token)
  end

end