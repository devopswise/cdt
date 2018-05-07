#!/usr/bin/python

import smtplib

sender = 'norely@gmail.com'
receivers = ['admin@gmail.com']

message = """From: From Person <noreply@gmail.com>
To: To Person <admin@gmail.com>
Subject: SMTP e-mail test

This is a test e-mail message.
"""

try:
   smtpObj = smtplib.SMTP('localhost')
   smtpObj.sendmail(sender, receivers, message)
   print "Successfully sent email"
except SMTPException:
   print "Error: unable to send email"

