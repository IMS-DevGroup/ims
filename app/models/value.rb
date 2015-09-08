class Value < ActiveRecord::Base

  belongs_to :device
  belongs_to :property

  validates :value , presence: true
  #validates :property_id , presence: true


  def getConvertedValue
    typ =self.property.data_type.name

    if typ == "String"
      return self.value
    elsif typ == "Fixnum"
      return self.value.to_i
    elsif typ == "Time"
      return Time.parse(self.value)
    elsif typ =="Boolean"
      return true if self.value=="true"
      return false if self.value=="false"
    elsif typ == "Float"
      return self.value.to_f
    end
  end
  def setConvertedValue(v_karl)

    typ =self.property.data_type.name
    puts typ
    if typ==v_karl.class.to_s

    self.value=v_karl.to_s


    elsif v_karl.class.to_s=="TrueClass"&& typ="Boolean"
      self.value="true"

    elsif v_karl.class.to_s=="FalseClass"&& typ="Boolean"
      self.value="false"
    else
       flash[:ERROR] =self.property.name + " is " + v.class + " not " + @typ
    end
    self.save

  end

end
