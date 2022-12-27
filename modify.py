Import-Module ActiveDirectory

$users = Import-Csv -Path 'modify.csv' -Header "username", "new_first_name", "new_last_name", "new_username"
foreach ($user in $users) {
    $username = $user.username
    $new_first_name = $user.new_first_name
    $new_last_name = $user.new_last_name
    $new_username = $user.new_username

    if (Get-ADUser -Filter {SamAccountName -eq $username}) {
        try {
            # Modifiez le prénom, le nom et le nom de compte de l'utilisateur
            Set-ADUser -Identity (Get-ADUser -Filter {SamAccountName -eq $username}) -GivenName $new_first_name -Surname $new_last_name -SamAccountName $new_username
            Write-Host "$username a bien ete modifie"
        }
        catch {
            Write-Host "Une erreur s'est produite lors de la modification de $username"
        }
    }
    else {
        Write-Host "Il n'y a pas d'utilisateur $username"
    }
}
