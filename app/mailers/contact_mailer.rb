class ContactMailer < ApplicationMailer
  
  def contact_mail(contact)
    @contact = contact
    mail(
    to: @contact.email,
    bcc: ENV["ACTION_MAILER_USER"],
    from: 'Festival Auction',
    subject: 'お問い合わせに対する回答'
    )
  end

end
