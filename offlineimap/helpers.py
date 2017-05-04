import subprocess

def get_password(account_name):
    password=subprocess.Popen('pass ' + account_name , shell = True,
            stdout=subprocess.PIPE).stdout.read().rstrip()
    return password
