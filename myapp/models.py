from django.db import models

# Create your models here.
class login_table(models.Model):
    username=models.CharField(max_length=100)
    password=models.CharField(max_length=100)
    type=models.CharField(max_length=100)
    status = models.CharField(max_length=100)


class user(models.Model):
    LOGIN = models.ForeignKey(login_table,on_delete=models.CASCADE)
    first_name = models.CharField(max_length=70)
    last_name = models.CharField(max_length=70)
    email = models.CharField(max_length=50)
    phone = models.BigIntegerField()
    gender= models.CharField(max_length=400)
    place= models.CharField(max_length=400)
    post= models.CharField(max_length=100)
    pin = models.BigIntegerField()
    photo = models.FileField()
    dob = models.DateField()
    status = models.CharField(max_length=100)


class chat_table(models.Model):
    FROM_id = models.ForeignKey(login_table,on_delete=models.CASCADE,related_name='fromidd')
    TO_id = models.ForeignKey(login_table, on_delete=models.CASCADE, related_name='toidd')
    date_time=models.DateTimeField()
    message = models.CharField(max_length=600)
    status = models.CharField(max_length=100)

class request_table(models.Model):
    FROM_id = models.ForeignKey(user, on_delete=models.CASCADE,related_name='fromid')
    TO_id = models.ForeignKey(user, on_delete=models.CASCADE,  related_name='toid')
    status = models.CharField(max_length=50)
    date_time=models.DateTimeField()
    # status = models.CharField(max_length=100)

class feedback(models.Model):
    USER = models.ForeignKey(user, on_delete=models.CASCADE)
    feedback= models.CharField(max_length=400)
    rating =models.CharField(max_length=50)
    date_time=models.DateTimeField()
    status = models.CharField(max_length=100)

class complaint(models.Model):
    date_time=models.DateTimeField()
    replay = models.CharField(max_length=200)
    complaint= models.CharField(max_length=400)
    USER = models.ForeignKey(user, on_delete=models.CASCADE)
    status = models.CharField(max_length=100)

class post(models.Model):
    USER = models.ForeignKey(user, on_delete=models.CASCADE,related_name='users')
    post= models.TextField()
    title= models.TextField()
    description= models.TextField()
    date_time=models.DateTimeField()
    photo = models.FileField()
    status = models.TextField()

class comments(models.Model):
    POST = models.ForeignKey(post, on_delete=models.CASCADE)
    comment = models.CharField(max_length=500)
    USER = models.ForeignKey(user, on_delete=models.CASCADE)
    date_time=models.DateTimeField()
    status = models.CharField(max_length=100)


