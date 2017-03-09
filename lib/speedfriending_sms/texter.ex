defmodule SfSms.Texter do
  def send_text_message(phone_number, message) do
    ExTwilio.Api.create(ExTwilio.Message,
      [to: phone_number, 
      from: Application.get_env(:ex_twilio, :send_number), 
      body: message])
  end
end