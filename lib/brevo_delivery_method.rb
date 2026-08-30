require "net/http"
require "json"

class BrevoDeliveryMethod
  def initialize(settings)
    @api_key = settings[:api_key]
  end

  def deliver!(mail)
    uri = URI("https://api.brevo.com/v3/smtp/email")
    req = Net::HTTP::Post.new(uri, {
      "api-key" => @api_key,
      "Content-Type" => "application/json"
    })
    req.body = {
      sender: { email: mail.from.first },
      to: mail.to.map { |email| { email: email } },
      subject: mail.subject,
      htmlContent: mail.html_part ? mail.html_part.body.decoded : mail.body.decoded
    }.to_json

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
  end
end
