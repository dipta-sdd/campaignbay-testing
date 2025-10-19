#!/bin/bash

# Function to display the main menu
show_main_menu() {
    echo "----------------------------------------"
    echo "      Environment Management Script"
    echo "----------------------------------------"
    echo "1. Prepare and Setup Environments"
    echo "2. Start Environments"
    echo "3. Stop Environments"
    echo "4. Clear Logs"
    echo "5. Exit"
    echo "----------------------------------------"
    read -p "Enter your choice [1-5]: " main_choice
}

# Function to display the environment selection menu
show_env_menu() {
    echo "----------------------------------------"
    echo "  Select Environment(s)"
    echo "----------------------------------------"
    echo "a. All Environments"
    echo "1. Environment 1"
    echo "2. Environment 2"
    echo "3. Environment 3"
    echo "4. Environment 4"
    echo "5. Environment 5"
    echo "6. Environment 6"
    echo "7. Environment 7"
    echo "8. Environment 8"
    echo "b. Back to Main Menu"
    echo "----------------------------------------"
    read -p "Enter your choice [a, 1-8, b]: " env_choice
}

# Function to prepare and setup environments
prepare_setup() {
    show_env_menu
    case $env_choice in
        a)
            echo "Preparing and setting up all environments..."
            ./prepare_all_envs.sh
            ./setup_all.sh
            ;;
        [1-8])
            echo "Setting up environment $env_choice..."
            cd "env-0$env_choice"
            ./setup.sh
            cd ..
            ;;
        b)
            return
            ;;
        *)
            echo "Invalid choice. Please try again."
            prepare_setup
            ;;
    esac
}

# Function to start environments
start_envs() {
    show_env_menu
    case $env_choice in
        a)
            echo "Starting all environments..."
            ./start_all.sh
            ;;
        [1-8])
            echo "Starting environment $env_choice..."
            cd "env-0$env_choice"
            docker-compose up -d
            cd ..
            ;;
        b)
            return
            ;;
        *)
            echo "Invalid choice. Please try again."
            start_envs
            ;;
    esac
}

# Function to stop environments
stop_envs() {
    show_env_menu
    case $env_choice in
        a)
            echo "Stopping all environments..."
            for i in $(seq -f "%02g" 1 8); do
                echo "Stopping environment in env-$i..."
                if [ -d "env-$i" ]; then
                    cd "env-$i"
                    docker-compose down
                    cd ..
                fi
            done
            ;;
        [1-8])
            echo "Stopping environment $env_choice..."
            cd "env-0$env_choice"
            docker-compose down
            cd ..
            ;;
        b)
            return
            ;;
        *)
            echo "Invalid choice. Please try again."
            stop_envs
            ;;
    esac
}

# Function to clear logs
clear_logs() {
    echo "Clearing logs..."
    ./clear_log.sh
}

# Main loop
while true; do
    show_main_menu
    case $main_choice in
        1)
            prepare_setup
            ;;
        2)
            start_envs
            ;;
        3)
            stop_envs
            ;;
        4)
            clear_logs
            ;;
        5)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
