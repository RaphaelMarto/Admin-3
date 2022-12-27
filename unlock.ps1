Import-Module ActiveDirectory

$users = Import-Csv -Path 'unlock.csv' -Header "username"
foreach ($user in $users) {
    $username = $user.username

    if (Get-ADUser -Filter {SamAccountName -eq $username}) {
        try {
            Unlock-ADAccount -Identity (Get-ADUser -Filter {SamAccountName -eq $username})
            Write-Host "$username a bien ete debloque"
        }
        catch {
            Write-Host "Une erreur s'est produite lors du deblocage de $username"
        }
    }
    else {
        Write-Host "Il n'y a pas d'utilisateur $username"
    }
}
