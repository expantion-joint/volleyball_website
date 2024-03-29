class ContactsController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]

  def index
    @contacts = Contact.all
    render :index
  end

  def new
    @contact = Contact.new
    render :new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      begin
        ContactMailer.contact_create_mail(@contact).deliver_now
      rescue => e
        puts "An error occurred: #{e.message}"
      end
      redirect_to index_post_path, notice: 'お問い合わせを送信しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @contact = Contact.find(params[:id])
    user = User.find(current_user.id)

    if user.usertype > 90
      render :edit
    else
      redirect_to index_post_path
    end
  end

  def update
    @contact = Contact.find(params[:id])
    user = User.find(current_user.id)
    
    if user.usertype > 90
      if @contact.update(contact_params)
        begin
          ContactMailer.contact_mail(@contact).deliver_now
          redirect_to :back, notice: 'メールが送信されました'
        rescue => e
          puts "An error occurred: #{e.message}"
          render :edit, alert: 'メールの送信中にエラーが発生しました。'
        end
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to index_post_path
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    user = User.find(current_user.id)

    if user.usertype > 90
      @contact.destroy
      redirect_to index_contact_path, notice: '問い合わせを削除しました'
    else
      redirect_to index_post_path
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :content, :title, :answer)
  end

end
