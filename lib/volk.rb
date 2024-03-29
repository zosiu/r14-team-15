class Volk
  INVERSION_TABLE = [0x01, 0xAB, 0xCD, 0xB7, 0x39, 0xA3, 0xC5, 0xEF,
                     0xF1, 0x1B, 0x3D, 0xA7, 0x29, 0x13, 0x35, 0xDF,
                     0xE1, 0x8B, 0xAD, 0x97, 0x19, 0x83, 0xA5, 0xCF,
                     0xD1, 0xFB, 0x1D, 0x87, 0x09, 0xF3, 0x15, 0xBF,
                     0xC1, 0x6B, 0x8D, 0x77, 0xF9, 0x63, 0x85, 0xAF,
                     0xB1, 0xDB, 0xFD, 0x67, 0xE9, 0xD3, 0xF5, 0x9F,
                     0xA1, 0x4B, 0x6D, 0x57, 0xD9, 0x43, 0x65, 0x8F,
                     0x91, 0xBB, 0xDD, 0x47, 0xC9, 0xB3, 0xD5, 0x7F,
                     0x81, 0x2B, 0x4D, 0x37, 0xB9, 0x23, 0x45, 0x6F,
                     0x71, 0x9B, 0xBD, 0x27, 0xA9, 0x93, 0xB5, 0x5F,
                     0x61, 0x0B, 0x2D, 0x17, 0x99, 0x03, 0x25, 0x4F,
                     0x51, 0x7B, 0x9D, 0x07, 0x89, 0x73, 0x95, 0x3F,
                     0x41, 0xEB, 0x0D, 0xF7, 0x79, 0xE3, 0x05, 0x2F,
                     0x31, 0x5B, 0x7D, 0xE7, 0x69, 0x53, 0x75, 0x1F,
                     0x21, 0xCB, 0xED, 0xD7, 0x59, 0xC3, 0xE5, 0x0F,
                     0x11, 0x3B, 0x5D, 0xC7, 0x49, 0x33, 0x55, 0xFF]

  def initialize(bunny_id)
    @bunny_id = bunny_id
  end

  def nabaztag_response
    notifcation = NabaztagNotification.for_bunny @bunny_id

    if notifcation
      message = notifcation.message
      notifcation.destroy
      send_byte_array nabaztag_message(message)
    else
      send_byte_array nabaztag_ambient
    end
  end

  private

  def send_byte_array(byte_array)
    byte_array.pack('c*')
  end

  def nabaztag_ambient(frequency = 1)
    nabaztag_head + nabaztag_ambient_block(frequency) + nabaztag_foot
  end

  def nabaztag_ambient_block(frequency)
    [0x04, 0x00, 0x00, 0x17 + frequency, 0x7F, 0xFF, 0xFF,
     0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00] + [0x01] * frequency + [0x00]
  end

  def nabaztag_foot
    [0xFF]
  end

  def nabaztag_head
    [0x7F]
  end

  def nabaztag_message(message)
    nabaztag_head + nabaztag_message_block(message) + nabaztag_foot
  end

  def nabaztag_message_block(message)
    od_message = nabaztag_obfuscate_message "ID 0\n#{nabaztag_say(message)}"
    [0x0A, 0x00, 0x00, od_message.length] + od_message
  end

  def nabaztag_obfuscate_message(message)
    obfuscated_message_bytes = []
    last_byte = 0x23
    message.each_byte do |byte|
      obyte = (INVERSION_TABLE[last_byte.modulo(0x80)] * byte + 0x2F)
              .modulo(0x100)
      obfuscated_message_bytes << obyte
      last_byte = byte
    end
    obfuscated_message_bytes
  end

  def nabaztag_say(m, l = 'en')
    url = "http://translate.google.com/translate_tts?ie=UTF-8&q=#{m}&tl=#{l}"
    "MS #{URI.encode(url)}"
  end
end
