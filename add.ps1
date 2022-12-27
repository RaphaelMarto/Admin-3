Import-Module ActiveDirectory


$users = Import-Csv -Path 'add.csv'
foreach ($user in $users) {
    $last_name = $user.last_name
    $first_name = $user.first_name
    $full_name = "$first_name $last_name"
    $username = $user.username
    $password = $user.password
    

    $user_obj =  -ErrorAction SilentlyContinue
    if (Get-ADUser -Filter {SamAccountName -eq $username}) {
        Write-Host "Il existe déjà un utilisateur $username"
    }
    else {
        $ou = 'ou=Utlisateurs ,dc=L2-4,dc=com'
        New-ADUser -SamAccountName $username -GivenName $first_name -Surname $last_name -DisplayName $full_name -Path $ou -AccountPassword (ConvertTo-SecureString -AsPlainText $password -Force) -Enabled $true
        Write-Host "The account $username was created in Active Directory."
        }
    }
}
