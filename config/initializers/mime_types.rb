# Be sure to restart your server when you modify this file.
Paperclip.options[:content_type_mappings] = { csv: 'application/vnd.ms-excel' }
# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
comma_separated_values = MIME::Types["text/comma-separated-values"].first
comma_separated_values.extensions << "csv"
MIME::Types.index_extensions comma_separated_values
