PS3='Please select an option: '
options=("Option 1" "Option 2" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "You chose Option 1"
            # run command 1
            ;;
        "Option 2")
            echo "You chose Option 2"
            # run command 2
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done