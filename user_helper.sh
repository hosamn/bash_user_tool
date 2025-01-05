#!/bin/bash

options=("Add User" "Delete User" "Add Group" "Delete Group" "List User Details" "Change User Password" "Lock Account" "Unlock Account" "Disable Account" "Update Username" "Exit" )


while true; do

    choice=$(zenity --list \
        --title="System Admin helper tool" \
        --column="Options" "${options[@]}" \
        --width=400 \
        --height=400 \
    --auto-scroll)


    if [[ $? -ne 0 ]]; then
        echo "No option selected."
        exit 1
    fi




    case $choice in
        "Add User")
            username=$(zenity --entry --title="Add User" --text="Enter username:")
            if [[ $? -eq 0 ]]; then
                if sudo useradd $username 2>/dev/null; then
                    zenity --info --title="User Added" --text="User $username added successfully."
                else
                    zenity --error --title="Error" --text="Failed to add user $username. Please check if the user already exists or try again later."
                fi
            else
                echo "Operation canceled."
            fi
        ;;
        "Delete User")
            username=$(zenity --entry --title="Delete User" --text="Enter username to delete:")
            if [[ $? -eq 0 ]]; then
                if sudo userdel $username 2>/dev/null; then
                    zenity --info --title="User Deleted" --text="User $username deleted successfully."
                else
                    zenity --error --title="Error" --text="Failed to delete user $username. Please check if the user exists or try again later."
                fi
            else
                echo "Operation canceled."
            fi
        ;;
        "Add Group")
            groupname=$(zenity --entry --title="Add Group" --text="Enter group name:")
            if [[ $? -eq 0 ]]; then
                if sudo groupadd $groupname 2>/dev/null; then
                    zenity --info --title="Group Added" --text="Group $groupname added successfully."
                else
                    zenity --error --title="Error" --text="Failed to add group $groupname. Please check if the group already exists or try again later."
                fi
            else
                echo "Operation canceled."
            fi
        ;;
        "Delete Group")
            groupname=$(zenity --entry --title="Delete Group" --text="Enter group name to delete:")
            if [[ $? -eq 0 ]]; then
                if sudo groupdel $groupname 2>/dev/null; then
                    zenity --info --title="Group Deleted" --text="Group $groupname deleted successfully."
                else
                    zenity --error --title="Error" --text="Failed to delete group $groupname. Please check if the group exists or try again later."
                fi
            else
                echo "Operation canceled."
            fi
        ;;
        "List User Details")
            username=$(zenity --entry --title="List user details" --text="Enter username to list its details:")
            if [[ $? -eq 0 ]]; then
                if sudo id $username 1>user-details 2>/dev/null; then
                    zenity --info --title="User $username details" --text="$(cat user-details) ."
                else
                    zenity --error --title="Error" --text="Failed to list detail for $username. Please check if the user exists or try again later."
                fi
            else
                echo "Operation canceled."
            fi
        ;;
        "Change User Password")
            username=$(zenity --entry --title="Change User Password" --text="Enter username:")
            password=$(zenity --entry --title="Change User Password" --text="Enter new password:")
            if echo $password | passwd --stdin $username; then
                zenity --info --title="Change User: $(username) Password" --text="password changed successfully."

            else
                zenity --error --title="Error" --text="Failed to change password for $username. Please check if the user exists or try again later."
            fi
        ;;
        "Lock Account")
            username=$(zenity --entry --title="Lock Account" --text="Enter username to lock:")
            if sudo usermod --lock $username; then
                zenity --info --title="Account Locked" --text="Account $username locked successfully."
            else
                zenity --error --title="Error" --text="Failed to lock account for $username. Please check if the user exists or try again later."
            fi
        ;;
        "Unlock Account")
            username=$(zenity --entry --title="Unlock Account" --text="Enter username to unlock:")
            if sudo usermod --unlock $username; then
                zenity --info --title="Account Unlocked" --text="Account $username unlocked successfully."
            else
                zenity --error --title="Error" --text="Failed to unlock account for $username. Please check if the user exists or try again later."
            fi
        ;;
        "Update Username")
            username=$(zenity --entry --title="Update Account" --text="Enter username to update:")
            newusername=$(zenity --entry --title="Update Account" --text="Enter new username:")
            if sudo usermod -l $newusername $username; then
                zenity --info --title="Account Updated" --text="Account updated successfully."
            else
                zenity --error --title="Error" --text="Failed to update account for $username. Please check if the user exists or try again later."
            fi
        ;;
        "Disable Account")
            username=$(zenity --entry --title="Disable Account" --text="Enter username to disable:")
            if sudo  passwd -l $username; then
                zenity --info --title="Account Updated" --text="Account updated successfully."
            else
                zenity --error --title="Error" --text="Failed to update account for $username. Please check if the user exists or try again later."
            fi
        ;;

        "Exit")
            echo "Exiting the program."
            exit 0
        ;;
        *)
            echo "Invalid option"
        ;;
    esac
done
