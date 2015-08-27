
class DocusignController < ApplicationController
  # the view corresponding to this action has the iFrame in it with the
  # @url as it's src. @envelope_response is populated from either:
  # @envelope_response = client.create_envelope_from_document
  # or
  # @envelope_response = client.create_envelope_from_template
  def embedded_signing
    client = DocusignRest::Client.new
    @id = client.get_account_id

    @document_envelope_response = client.create_envelope_from_document(
      email: {
        subject: "test email subject",
        body: "this is the email body and it's large!"
      },
      # If embedded is set to true  in the signers array below, emails
      # don't go out to the signers and you can embed the signature page in an
      # iFrame by using the client.get_recipient_view method
      signers: [
        {
          embedded: true,
          name: 'Helder Suzuki',
          email: 'heldersuzuki@gmail.com',
          role_name: 'Issuer',
          # sign_here_tabs: [
          #   {
          #     anchor_string: 'sign_here_1',
          #     anchor_x_offset: '140',
          #     anchor_y_offset: '8'
          #   }
          # ]
        },
        {
          embedded: true,
          name: 'Test Girl',
          email: 'someone+else@gmail.com',
          role_name: 'Attorney',
          # sign_here_tabs: [
          #   {
          #     anchor_string: 'sign_here_2',
          #     anchor_x_offset: '140',
          #     anchor_y_offset: '8'
          #   },
          #   {
          #     anchor_string: 'sign_here_3',
          #     anchor_x_offset: '140',
          #     anchor_y_offset: '8'
          #   }
          # ]
        }
      ],
      files: [
        {path: '/Users/MinKim/Dreamfunded/dreamfunded/app/assets/doc/test.pdf', name: 'test.pdf'}
      ],
      status: 'sent'
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
      envelope_id: @document_envelope_response['envelopeId'],
      name: 'Helder Suzuki',
      email: 'heldersuzuki@gmail.com',
      return_url: 'https://www.dreamfunded.vc',
    )
  end

  def get_envelope
  end

end
