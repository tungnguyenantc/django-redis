from celery import shared_task
from django.core.mail import send_mail
from datetime import datetime



@shared_task
def send_email(email):
    try:

        sender_address = "tungnguyen.antc@gmail.com"
        subject = f'xác minh đăng ký sign up {datetime.now()}'
        body = 'hello các bạn'
        user_address = email
        send_mail(subject, message=body, from_email=sender_address,
                  recipient_list=[user_address])
    except Exception as e:
        print(e)
    finally:
        print('exit')