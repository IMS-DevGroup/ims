class Value < ActiveRecord::Base

  belongs_to :device
  belongs_to :property

  validates :value , presence: true
  validates :device_id , presence: true
  validates :property_id , presence: true

  def getConvertedValue
    type =self.property.data_type.name

    if type == "string"
      return self.value
    elsif type == "integer"
      return self.value.to_i
    elsif type == "timestamp"
      return Time.parse(self.value)
    elsif type =="boolean"
      return true if self.value=="true"
      return false if self.value=="false"
    elsif type == "float"
      return self.value.to_f
    end
  end
  def setConvertedValue(v)
    self.value=v.to_s
  end

end
