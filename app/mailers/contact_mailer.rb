class ContactMailer < ApplicationMailer
  
  def contact_mail(contact)
    @contact = contact
    mail(
    to: @contact.email,
    bcc: ENV["ACTION_MAILER_USER"],
    from: 'イベント予約サイトTogether',
    subject: 'お問い合わせに対する回答'
    )
  end

  def contact_create_mail(contact)
    @contact = contact
    mail(
    to: ENV["ACTION_MAILER_USER"],
    from: 'イベント予約サイトTogether',
    subject: 'お問い合わせ内容'
    )
  end

end
