Import-Module ActiveDirectory
Get-ADUser -Filter * -Properties PasswordLastSet | select Name, PasswordLastSet, Enabled | Out-GridView
