Import-Module ActiveDirectory

# Open the CSV file and read each line
$users = Import-Csv -Path 'add.csv'
foreach ($user in $users) {
    # Retrieve user information from the CSV line
    $last_name = $user.last_name
    $first_name = $user.first_name
    $full_name = "$first_name $last_name"
    $username = $user.username
    $password = $user.password
    
    # Check if the user account already exists in Active Directory
    $user_obj = Get-ADUser -Filter {SamAccountName -eq $username} -ErrorAction SilentlyContinue
    if (!$user_obj) {
        # If the account doesn't exist, create it with the provided information
        $ou = 'ou=Utlisateurs ,dc=L2-4,dc=com'
        try {
            New-ADUser -SamAccountName $username -GivenName $first_name -Surname $last_name -DisplayName $full_name -Path $ou -AccountPassword (ConvertTo-SecureString -AsPlainText $password -Force) -Enabled $true
            
            # Display a message indicating that the account was created
            Write-Host "The account $username was created in Active Directory."
        }
        catch {
            # If an error occurs, display an error message
            Write-Host "An error occurred while creating the account $username in Active Directory: $_"
        }
    }
    else {
        # If the account already exists, display an error message
        Write-Host "The account $username already exists in Active Directory."
    }
}
