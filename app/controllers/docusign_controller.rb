class DocusignController < ApplicationController
  # the view corresponding to this action has the iFrame in it with the
  # @url as it's src. @envelope_response is populated from either:
  # @envelope_response = client.create_envelope_from_document
  # or
  # @envelope_response = client.create_envelope_from_template
  def embedded_signing
    client = DocusignRest::Client.new
    @url = client.get_recipient_view(
      envelope_id: @envelope_response["envelopeId"],
      name: current_user.display_name,
      email: current_user.email,
      return_url: "http://localhost:3000/docusign_response"
    )
  end  
end
