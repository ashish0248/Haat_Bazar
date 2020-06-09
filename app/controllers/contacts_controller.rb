class ContactsController < ApplicationController

	def new
		@contact_new = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)
		@contact.name = current_user.name
		@contact.email = current_user.email
		if @contact.save
			# メールで送信
			ContactMailer.send_mail(@contact).deliver unless @contact.invalid?
			redirect_to root_path
		end
	end

	private

	def contact_params
		params.require(:contact).permit(:message)
	end
end
