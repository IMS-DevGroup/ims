require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'

class BarcodeTestsController < ApplicationController
  # GET /barcode_tests
  # GET /barcode_tests.json
  def index
    if(!params[:device_id].nil?)
    @prodid = params[:device_id]
    @device = Device.find_by_id(@prodid)
    @barcode = Barby::Code128B.new((86324120+@prodid.to_f).to_s)
    if(!File.exist?('public/barcodes/'+@prodid.to_s+'.png'))
      File.open('public/barcodes/'+@prodid.to_s+'.png', 'w'){|f|
        f.write @barcode.to_png()
      }
    end
    else
      flash[:error] ="DeviceID is missing!"
    end
    render :layout => 'empty_layout'

    remove_old_barcodes
  end

  #deletes barcodes which are older 0.03days
  def remove_old_barcodes
    Dir.foreach('public/barcodes') do |filename|
      next if filename == '.' or filename == '..'
      time = (Time.now - File.stat('public/barcodes/'+filename).mtime).to_i / 86400.0
      if(time>0.03)
        File.delete('public/barcodes/'+filename)
      end
    end
  end
end
