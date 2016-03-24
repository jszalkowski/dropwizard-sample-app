from fabric.api import *

env.warn_only = True

def deploy():
    stop()
    copy_artefact()
    copy_configuration()
    migrate()
    start()

def copy_artefact():
    put("target/sample-app-1.0-SNAPSHOT.jar", "/home/deployer/")

def copy_configuration():
    put("configuration.yml", "/home/deployer/")

def start():
    run("screen -S sample-app -d -m java -jar /home/deployer/sample-app-1.0-SNAPSHOT.jar server configuration.yml", pty=False)

def stop():
    run("screen -S sample-app -X quit", pty=False)

def migrate():
    run("java -jar /home/deployer/sample-app-1.0-SNAPSHOT.jar db migrate configuration.yml")
