import os
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail

message = Mail(
    from_email='{}',
    to_emails=[{}],
    subject='{}',
    html_content='Email Deliverability Analytics using SendGrid and AWS Big Data Services')
try:
    sg = SendGridAPIClient('{}')
    response = sg.send(message)
    print(response.status_code)
    print(response.body)
    print(response.headers)
except Exception as e:
    print(e.message)