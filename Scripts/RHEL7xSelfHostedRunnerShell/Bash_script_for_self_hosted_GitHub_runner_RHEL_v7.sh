########-------- Parameters --------#########################################
# $1 The path for the Github repo, https://github.com/<orgname>/<reponame>  #
# $2 Github Account PAT Token with access to the desired repo               #
#############################################################################

#Bash script for self-hosted runner using the 7.8 rhel gallery image and using a public IP to allow the connection to Azure RHUI repos

#Elevate to avoid permission issues
sudo -i

#Install Azure cli on RHEL - Reference - https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-yum?view=azure-cli-latest
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo
sudo yum -y install azure-cli

#Install Powershell Core - Reference - https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7#red-hat-enterprise-linux-rhel-7
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo
sudo yum install -y powershell
#Install Azure module for Powershell
sudo pwsh -Command "Install-Module -Name Az -AllowClobber -Scope AllUsers -Force"


#The script often pauses at this stage. So paste in the rest and continue

#Install Docker CE
# Update system.
sudo yum update -y
#Add Centos extras repo
#Input information directly instead of using .repo to avoid use of variables that won't work
sudo echo "[CentOS-extras]
name=CentOS-extras
baseurl=http://mirror.centos.org/centos/7/extras/x86_64/
enabled=1
gpgcheck=0
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7" > /etc/yum.repos.d/centosextras.repo
#Install container-selinux.
sudo yum install -y container-selinux
# Set up Docker repository.
#Input information directly instead of using .repo to avoid use of variables that won't work
sudo echo "[docker-ce-stable]
name=Docker CE Stable
baseurl=https://download.docker.com/linux/centos/7/x86_64/stable
enabled=1
gpgcheck=0
gpgkey=https://download.docker.com/linux/centos/gpg" > /etc/yum.repos.d/docker-ce.repo
# Install Docker CE and tools.
sudo yum install -y docker-ce docker-ce-cli containerd.io
# Add current user to docker group.
sudo usermod -a -G docker $USER
# Start and enable docker service.
sudo systemctl start docker
sudo systemctl enable docker
# Run the following command to make sure the installation is working.
sudo docker run hello-world

#Exit the root context for the runner installation - the runner can't be configured with sudo
exit

#Setup for runner using instructions from GitHub repo under Settings\Actions\Add self-hosted runner. 
#Make sure the client version hasn't changed as they keep it updated to the last version.
sudo mkdir actions-runner && cd actions-runner
sudo curl -O -L https://github.com/actions/runner/releases/download/v2.277.1/actions-runner-linux-x64-2.277.1.tar.gz
sudo tar xzf ./actions-runner-linux-x64-2.277.1.tar.gz


#Add your repo path and token after getting it from the GitHub repo (in the UI) under Settings\Actions\Add self-hosted runner.
#Then run the following three commands
#Verify the actions-runner directory has the read, write and execute permissions in the directory
sudo chmod 777 -R ./
./config.sh --url $1 --token $2 --unattended
sudo ./svc.sh install
sudo ./svc.sh start
sudo usermod -a -G docker $USER


#Reboot to ensure permissions are set
#Then run the following to verify permissions are working (without sudo)
#docker run hello-world



#If you look in the GitHub repo Settings\Actions you should see your idle self-hosted runner
#In one case the sudo ./svc.sh start needed to be run again

#In case you have issues related to the ./config.sh command requirement to run with a non-sudo account
#You can exit the root account and run the lines from sudo mkdir to sudo usermod -a -G docker $USER