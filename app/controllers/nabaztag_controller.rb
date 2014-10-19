require 'volk'

class NabaztagController < ApplicationController
  before_action :authenticate_user!, only: :set_nabaztag_uid

  def ping
    render text: Volk.new(params[:nabaztag_id]).nabaztag_response
  end

  def bytecode
    send_file "#{Rails.root}/public/downloads/bootcode/violet.bin"
  end

  def set_nabaztag_uid
    uid = params[:nabaztag][:mac_address].to_s.downcase.gsub(':', '')
    current_user.update_attribute :nabaztag_uid, uid
    redirect_to admin_nabaztag_settings_path
  end

  def nabaztag_tryme
    message = params[:nabaztag][:message]
    NabaztagNotification.create nabaztag_uid: current_user.nabaztag_uid,
                                message: message

    redirect_to admin_nabaztag_settings_path
  end

end
