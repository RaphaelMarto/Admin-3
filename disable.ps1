Import-Module ActiveDirectory

$users = Import-Csv -Path 'disable.csv' -Header "username"
foreach ($user in $users) {
    $username = $user.username

    if (Get-ADUser -Filter {SamAccountName -eq $username}) {
        try {
            Disable-ADAccount -Identity (Get-ADUser -Filter {SamAccountName -eq $username})
            Write-Host "$username à bien été désactivé"
        }
        catch {
            Write-Host "Une erreur s'est produite lors de la désactivation de $username"
        }
    }
    else {
        Write-Host "Il n'y a pas d'utilisateur $username"
    }
}
