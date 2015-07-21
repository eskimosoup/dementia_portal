class ContactMailer < ActionMailer::Base

  def new(site_settings, contact)
    @site_settings = site_settings
    @contact = contact
    mail to: @site_settings['Email'], from: @site_settings['Email'], subject: "Contact form completed - #{@site_settings['Name']}"
  end

end
