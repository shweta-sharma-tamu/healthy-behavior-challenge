class TodoReminderMailer < ApplicationMailer
    def remind (chmap, email,name)
        @chmap = chmap
        @name = name
        mail to: email, subject: "Reminder to Complete today's tasks!"
        
    end
end