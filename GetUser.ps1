
function Get-User {
    [CmdletBinding(DefaultParameterSetName = 'UserName')]
    param(
        [Parameter(
            Mandatory,
            ParameterSetName='UserName',
            ValueFromPipeline,
            Position = 1,
            HelpMessage = 'User to search for')]
        [ValidatePattern('^[A-F]+', ErrorMessage = 'Name has to start with a to f')]
        [string]$UserName,
        
        [Parameter(Mandatory, ParameterSetName='OlderThan', ValueFromPipeline, Position = 1)]
        [ValidateRange(18,100)]
        [int]$OlderThan,

        [switch]$MySwitch,
        
        [Parameter()]
        [ValidateScript({
            Test-Path -Path $_
        }, ErrorMessage = 'Path to file is bad and you should feel bad.')]
        $MyUserListFile = "C:\psadv\PSADVFundamentals\MyLabFile.csv"
    )

    $MyUserList = Get-Content -Path $MyUserListFile | ConvertFrom-Csv
    switch ($PSCmdlet.ParameterSetName) {
        UserName { $MyUserList | Where-Object -Property Name -Like "*$UserName*" }
        OlderThan { $MyUserList | Where-Object -Property Age -gt $olderThan }
        Default {}
    }
    if ($MySwitch) {
        Write-Output 'switch is on!'
    }
}


































# Get users about to retire
$MyUserListFile = "$PSScriptRoot\MyLabFile.csv"
$MyUserList = Get-Content -Path $MyUserListFile | ConvertFrom-Csv
$MyUserList | Where-Object -Property Age -ge 65

















# Select user and remove
[string]$MyUserListFile = "$PSScriptRoot\MyLabFile.csv"
$MyUserList = Get-Content -Path $MyUserListFile | ConvertFrom-Csv
$RemoveUser = $MyUserList | Out-GridView -PassThru
$MyUserList = $MyUserList | Where-Object {
    -not (
        $_.Name -eq $RemoveUser.Name -and
        $_.Age -eq $RemoveUser.Age -and
        $_.Color -eq $RemoveUser.Color -and
        $_.Id -eq $RemoveUser.Id
    )
}
Set-Content -Value $MyUserList -Path $MyUserListFile -WhatIf





























# Do stuff to every user based on value
$MyUserListFile = "$PSScriptRoot\MyLabFile.csv"
$MyUserList = Get-Content -Path $MyUserListFile | ConvertFrom-Csv
switch ($MyUserList) {
    { $_.Color -eq 'Yellow' } { "$($_.Name) is living in a $($_.Color) submarine." }
    { $_.Color -eq 'Purple' } { "$($_.Name) wants to see you cry in the $($_.Color) rain." }
    { $_.Color -eq 'Pink' } { "$($_.Name) is building a wall." }
    { $_.Color -eq 'Black' } { "$($_.Name) is painting a door." }
    { $_.Color -eq 'Green' } { "$($_.Name) went on a holiday." }
    { $_.Color -eq 'Blue' } { "$($_.Name) has a full tank of gas, half a pack of cigarettes, it's dark and he's wearing sunglasses." }
    default { Write-Output "$($_.Name) Needs to start a band" }
}

# Happy new year! Update everyones age by one
$MyUserListFile = "$PSScriptRoot\MyLabFile.csv"
$MyUserList = Get-Content -Path $MyUserListFile | ConvertFrom-Csv
foreach ($User in $MyUserList) {
    $User.age = $User.Age + 1
    Write-Output "$($User.Name) is $($User.Age) this year."
}
Set-Content -Value $MyUserList -Path $MyUserListFile -WhatIf
