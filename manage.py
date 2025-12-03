import sys
import os
import time # Import time for a brief, non-interactive pause

# --- Utility Functions ---

def clear_screen():
    """Clears the terminal screen for a cleaner menu display."""
    os.system('cls' if os.name == 'nt' else 'clear')

# We are removing pause_and_continue(), but keeping this brief pause 
# in the core execution function to allow the user to see the output before the screen clears.
def quick_pause():
    """A brief, non-interactive pause to display command output."""
    time.sleep(1.5) 


# --- Core Execution Function ---
# ~/Documents/campaign-bay-testing/plugin/dev-docs/run-local.sh campaignbay

def execute_env_action(action, container_number=None):
    """
    Executes various environment-specific commands (Docker, scripts, log clearing, etc.).
    :param action: 'up -d', 'down', 'clear_log', 'setup', or 'configure'.
    """
    
    # 1. Logic for ALL containers
    if container_number is None:
        if action in ('up -d', 'down', 'clear_log', 'setup', 'configure'):
            command_word = action.replace(' -d', '').upper()
            print(f"\n--- {command_word}ING ALL Containers (1 through 8) ---")
            
            for i in range(1, 9):
                # The execution status will print immediately
                execute_env_action(action, container_number=i) 
                
            print(f"\nFinished batch {command_word} operation.")
            quick_pause() # Pause here only once after the batch finishes
            return 
        else:
            print(f"\nERROR: Action '{action}' is not supported for 'All Containers'.")
            quick_pause()
            return
    
    # 2. Logic for a single container (Containers 1-8)
    env_dir = f"env-0{container_number}"
    base_cmd = f"cd {env_dir} && "
    
    # ... (Action determination logic remains the same) ...
    if action == 'up -d':
        task_description = f"Starting Container {container_number}"
        cmd = base_cmd + "docker compose up -d"
        
    elif action == 'down':
        task_description = f"Stopping Container {container_number}"
        cmd = base_cmd + "docker compose down"
        
    elif action == 'clear_log':
        task_description = f"Clearing logs for Container {container_number}"
        log_cmd = "docker compose exec wordpress sh -c 'for i in $(seq 1 60); do echo; done > /var/www/html/wp-content/debug.log'"
        cmd = base_cmd + log_cmd
        
    elif action == 'setup':
        task_description = f"Running setup script for Container {container_number}"
        cmd = base_cmd + "./setup.sh"
        
    elif action == 'configure':
        task_description = f"Running configuration script for Container {container_number}"
        cmd = base_cmd + "./configure.sh"
        
    else:
        print(f"\nERROR: Unknown action '{action}' requested for container {container_number}.")
        quick_pause()
        return

    # Execute the command
    print(f"\n[{task_description}] Executing: {cmd}")
    
    exit_code = os.system(cmd)
    
    if exit_code == 0:
        print(f"\nContainer {container_number} action '{action}' finished successfully.")
    else:
        print(f"\nERROR: Command failed for container {container_number} (Exit code: {exit_code}).")
        
    quick_pause() # Quick pause after any single command execution

# --- Container Menu Handlers (Generic) ---

def create_container_menu(menu_title, action):
    """Generic function to create Start/Stop/Clear/Setup sub-menus."""
    while True:
        clear_screen() 
        print(f"--- {menu_title.upper()} ---")
        
        # Display '0. All' option
        print(f"0. {menu_title} All")
        
        for i in range(1, 9):
            print(f"{i}. {menu_title} Container {i}")
            
        print("B. Back to Main Menu")

        choice = input("\nEnter your choice (0-8 or B): ").strip().upper()

        if choice == 'B':
            print("Returning to Main Menu...")
            break

        elif choice == '0':
            execute_env_action(action, container_number=None)
            # Removed pause_and_continue()
            
        elif choice.isdigit() and 1 <= int(choice) <= 8:
            container_num = int(choice)
            execute_env_action(action, container_number=container_num)
            # Removed pause_and_continue()
            
        else:
            print(f"**Invalid option: '{choice}'. Please try again.**")
            quick_pause() # Kept quick_pause for error messages

# Define the specific menus using the generic creator

def start_menu():
    create_container_menu("Start", 'up -d')

def stop_menu():
    create_container_menu("Stop", 'down')

def setup_menu():
    create_container_menu("Setup", 'setup')

def configure_menu():
    create_container_menu("Configure", 'configure')

def clear_log_menu():
    create_container_menu("Clear Log", 'clear_log') 
def create_dev_docs():
    """Runs the script to create development documentation."""
    clear_screen()
    print("\n--- Creating Development Documentation ---")
    print("Executing: ~/Documents/campaign-bay-testing/plugin/dev-docs/run-local.sh campaignbay")
    
    # The command path needs to be absolute or relative to the script's execution directory
    # Assuming the script is run from the project root, or the path is correctly handled by the shell.
    # For robustness, consider using os.path.expanduser for '~'
    cmd = os.path.expanduser('~/Documents/campaign-bay-testing/plugin/dev-docs/run-local.sh campaignbay')
    
    exit_code = os.system(cmd)
    
    if exit_code == 0:
        print("\nDevelopment documentation creation finished successfully.")
    else:
        print(f"\nERROR: Documentation creation failed (Exit code: {exit_code}).")
        
    quick_pause()
    

# --- Main Menu Handler ---

def main_menu():
    """Displays the main menu and handles user selection."""
    while True:
        clear_screen()
        
        print("--- MAIN MENU ---")
        print("1. Start (Containers)") 
        print("2. Stop (Containers)")
        print("3. Setup (Containers)")
        print("4. Configure (Containers)")
        print("5. Clear Logs (Containers)") 
        print("6. Create Dev Docs")
        print("7. Exit Application")

        choice = input("\nEnter your choice (1-6): ").strip() 

        if choice == '1':
            start_menu()
        elif choice == '2':
            stop_menu()
            
        elif choice == '3':
            # Setup Confirmation (Uses input for confirmation, not just pause)
            clear_screen()
            print("\n⚠️ **WARNING: SETUP IS A DESTRUCTIVE ACTION!**")
            confirm = input("Are you absolutely sure you want to proceed to the Setup menu? (yes/NO): ").strip().lower()
            if confirm in ('y', 'yes'):
                setup_menu()
            else:
                print("Setup cancelled. Returning to main menu.")
                quick_pause()
        
        elif choice == '4':
            # Configure Confirmation (Uses input for confirmation, not just pause)
            clear_screen()
            print("\n⚠️ **WARNING: CONFIGURATION CHANGES MAY BE CRITICAL!**")
            confirm = input("Are you absolutely sure you want to proceed to the Configure menu? (yes/NO): ").strip().lower()
            if confirm in ('y', 'yes'):
                configure_menu()
            else:
                print("Configuration cancelled. Returning to main menu.")
                quick_pause()
            
        elif choice == '5':
            clear_log_menu() 
        elif choice == '6':
            create_dev_docs()
        elif choice == '7':
            print("\nExiting application. Goodbye!")
            sys.exit(0)
        else:
            print(f"**Invalid option: '{choice}'. Please try again.**")
            quick_pause()


# --- Application Entry Point ---

if __name__ == "__main__":
    main_menu()
# stable