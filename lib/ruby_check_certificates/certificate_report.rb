require 'erb'

module RubyCheckCertificates
  class CertificateReport
    def initialize
      @certificates = []
      @checked_certificates = 0
    end

    def check_certificate(file, line, certificate)
      @checked_certificates += 1
      if certificate.not_after + 3600 * 24 * 30 * 2 < Time.now.utc
        @certificates << CertificateExpirationInfo.new(file, line, certificate)
      end
    end

    def errors?
      @certificates.count > 0
    end

    def error_count
      @certificates.count
    end

    def certificate_details(crt)
      erb = ERB.new <<EOT, nil, '<>'
  * <%= crt.file %>:<%= crt.line %>
    subject:   <%= crt.certificate.subject %>
    not_after: <%= crt.certificate.not_after %> (<%= n = ((Time.now.utc - crt.certificate.not_after) / (2600 * 24)).ceil %> day<%= 's' if n != 1 %> ago)
<% crt.certificate.extensions.each do |ext| %>
    <%= ext.oid %>: <%= ext.value.chomp.gsub("\n", "\n" + ' ' * (4 + ext.oid.length + 2)) %>
<% end %>
EOT
      erb.result(binding)
    end

    def to_s
      stop = Time.now.utc

      @certificates.sort! { |a, b| a.certificate.not_after <=> b.certificate.not_after }

      @expired = @certificates.select { |x| x.certificate.not_after <= stop }
      @one_week = @certificates.select { |x| x.certificate.not_after > stop && x.certificate.not_after <= stop + 3600 * 24 * 7 }
      @two_week = @certificates.select { |x| x.certificate.not_after > stop + 3600 * 24 * 7 && x.certificate.not_after <= stop + 3600 * 24 * 7 * 2 }
      @one_month = @certificates.select { |x| x.certificate.not_after > stop + 3600 * 24 * 7 * 2 && x.certificate.not_after <= stop + 3600 * 24 * 30 }
      @two_month = @certificates.select { |x| x.certificate.not_after > stop + 3600 * 24 * 30 && x.certificate.not_after <= stop + 3600 * 24 * 30 * 2 }
      erb = ERB.new <<EOT, nil, '<>'
<%= @certificates.count %> problem<%= 's' if @certificates.count != 1 %> found in <%= @checked_certificates %> certificate<%= 's' if @checked_certificates != 1 %>.
<% if @expired.count > 0 then %>

<%= @expired.count %> expired certificate<%= 's' if @expired.count != 1 %>:
<% @expired.each do |crt| %>
<%= certificate_details(crt) %>

<% end %>
<% end %>
<% if @one_week.count > 0 then %>

<%= @one_week.count %> certificate<%= 's' if @one_week.count != 1 %> expiring in less than 1 week:
<% @one_week.each do |crt| %>
<%= certificate_details(crt) %>

<% end %>
<% end %>
<% if @two_week.count > 0 then %>

<%= @two_week.count %> certificate<%= 's' if @two_week.count != 1 %> expiring in less than 2 weeks:
<% @two_week.each do |crt| %>
<%= certificate_details(crt) %>

<% end %>
<% end %>
<% if @one_month.count > 0 then %>

<%= @one_month.count %> certificate<%= 's' if @one_month.count != 1 %> expiring in less than 1 month:
<% @one_month.each do |crt| %>
<%= certificate_details(crt) %>

<% end %>
<% end %>
<% if @two_month.count > 0 then %>

<%= @two_month.count %> certificate<%= 's' if @two_month.count != 1 %> expiring in less than 2 months:
<% @two_month.each do |crt| %>
<%= certificate_details(crt) %>

<% end %>
<% end %>
EOT
      erb.result(binding)
    end
  end
end
