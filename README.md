The install.sh script configures Ubuntu desktop the way I like. The cookbooks and recipes are optimized for Ubuntu 16.04. Ideally, it should be ran on a newly installed system. Use it on your own risk.

* Install git

```sudo apt install git```

* Clone the repo

```git clone https://github.com/sbobylev/chef-ubuntu.git```

* Run the installer as a regular user. You'll be prompted to enter sudoers password during the install process. 

```cd chef-ubuntu && bash install.sh```
