class Right < ActiveRecord::Base
  after_create :default_values

  belongs_to :user

  validates :user_id , presence: true


  protected
  def default_values
    self.manage_users = false
    self.manage_devices = false
    self.manage_device_types = false
    self.manage_stocks_and_units = false
    self.manage_operations = false
    self.manage_rights = false
    self.manage_boss = false
    self.save
  end
end
