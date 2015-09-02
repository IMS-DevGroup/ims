require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'

class BarcodeTestsController < ApplicationController



  # GET /barcode_tests
  # GET /barcode_tests.json
  def index
    @prodid = '00000002'
    @barcode = Barby::Code128B.new(@prodid)
    if(!File.exist?('public/barcodes/'+@prodid+'.png'))
      File.open('public/barcodes/'+@prodid+'.png', 'w'){|f|
        f.write @barcode.to_png(:height => 60, :margin => 5)
      }
    end
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
