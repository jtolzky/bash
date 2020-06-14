#!/bin/bash
if [[ "${UID}" -ne 0 ]]
 then echo "Please run as root"
 exit 1
fi 

#Enter username
read -p "Enter the username to create: " USER_NAME

#Enter real name
read -p "Enter the name of the person or application that will be using this account: " COMMENT

#Enter password
read -p "Enter the password to use for the account: " PASSWORD

#Create the user with the password
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
 echo 'The useradd command did not execute successfully'
 exit 1
fi 

#Set password
echo "${PASSWORD}" | passwd --stdin ${USER_NAME}

#Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
 then
 echo 'The password command id not execute succesfully'
 exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user wascreated.
echo "username: ${USER_NAME}"
echo "password: ${PASSWORD}"
echo "host: ${HOSTNAME}"

