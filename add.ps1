Import-Module ActiveDirectory


$users = Import-Csv -Path 'add.csv' -Header "first_name", "last_name", "username", "password"
foreach ($user in $users) {
    $last_name = $user.last_name
    $first_name = $user.first_name
    $full_name = "$first_name $last_name"
    $username = $user.username
    $password = $user.password

    if (Get-ADUser -Filter {SamAccountName -eq $username}) {
        Write-Host "Il existe deja  un utilisateur $username"
    }
    else {
        $ou = 'ou=Utilisateurs,dc=L2-4,dc=lab'
        New-ADUser -Name $full_name -SamAccountName $username -GivenName $first_name -Surname $last_name -DisplayName $full_name -Path $ou -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force)
        Write-Host "$username a  bien ete creer"
    }
}
