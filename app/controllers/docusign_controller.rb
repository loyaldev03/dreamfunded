
class DocusignController < ApplicationController
  # the view corresponding to this action has the iFrame in it with the
  # @url as it's src. @envelope_response is populated from either:
  # @envelope_response = client.create_envelope_from_document
  # or
  # @envelope_response = client.create_envelope_from_template
  def embedded_signing
    client = DocusignRest::Client.new
    @envelope_response = client.create_envelope_from_template(
      status: 'sent',
      email: {
        subject: "The test email subject envelope",
        body: "Envelope body content here"
      },
      template_id: "22F408A5-1A62-4B4F-BF3C-0F9B41C7F522",
      signers: [
        {
          embedded: true,
          name: 'Min Kim',
          email: 'tomas0706@naver.com',
          role_name: 'Investor'
        },
      ]
    )

    # Public returns the URL for embedded signing
    #
    # envelope_id - the ID of the envelope you wish to use for embedded signing
    # name        - the name of the signer
    # email       - the email of the recipient
    # return_url  - the URL you want the user to be directed to after he or she
    #               completes the document signing
    # headers     - optional hash of headers to merge into the existing
    #               required headers for a multipart request.
    #
    # Returns the URL string for embedded signing (can be put in an iFrame)
    @recipient_view = client.get_recipient_view(
      envelope_id: @envelope_response['envelopeId'],
      name: 'Min Kim',
      email: 'tomas0706@naver.com',
      return_url: 'https://www.dreamfunded.vc',
    )
  end

  def get_envelope
  end

end
