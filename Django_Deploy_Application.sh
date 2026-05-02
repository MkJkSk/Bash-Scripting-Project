#!/bin/bash


clone_code(){
	echo "Code Cloning..."
	git clone https://github.com/LondheShubham153/django-notes-app.git
}

Install_Requirements(){

	echo "Install Requirements..."
	sudo apt-get install docker.io nginx -y

}

Restart_Requirements(){
	echo "Restarting..."
	sudo chown $USER /var/run/docker.sock
	sudo systemctl enable docker
	sudo systemctl enable nginx
	sudo systemctl restart docker
}

deploy_Code(){
	docker build -t notes-app .
	docker run -d -p 8000:8000 notes-app:latest
	#docker-compose up -d
}       

echo "***** DEPLOYMENT STARTED*****"
if ! clone_code; then
	echo "the code directory already exists"
	cd django-notes-app
fi
if ! Install_Requirements; then
	echo "Installation Failed"
	exit 1
fi
if ! Restart_Requirements; then
	echo "System fault identify"
	exit 1
fi
deploy_Code
echo "***** DEPLOYMENT DONE*****"
