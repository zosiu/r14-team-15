require 'volk'

class NabaztagController < ApplicationController

  def ping
    render text: Volk.new(params[:nabaztag_id]).nabaztag_response
  end

  def bytecode
    send_file "#{Rails.root}/public/downloads/bootcode/violet.bin"
  end

end
