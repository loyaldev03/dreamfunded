class DocusignController < ApplicationController
  # the view corresponding to this action has the iFrame in it with the
  # @url as it's src. @envelope_response is populated from either:
  # @envelope_response = client.create_envelope_from_document
  # or
  # @envelope_response = client.create_envelope_from_template
  def embedded_signing

  end  

  def get_envelope
  end 

end
