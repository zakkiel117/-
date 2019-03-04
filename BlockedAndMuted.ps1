$cred = Get-Credential -Message "VRChatのUserIDとパスワード入力してください"
$pair = "$($cred.UserName):$($cred.GetNetworkCredential().Password)"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$Headers = @{
    Authorization = "Basic $encodedCreds"
}

$json = Invoke-WebRequest -Uri "https://api.vrchat.cloud/api/1/auth/user/playermoderated?apiKey=JlE5Jldo5Jibnk5O5hTx6XVqsJu4WJ26"  -Headers $Headers | ConvertFrom-JSON
$list = $json | Where-Object { $_.type -eq "block" -or $_.type -eq "mute" }
$list | Format-Table  -Property type, sourceDisplayName > "BlockedAndMuted.txt"

Add-Type -Assembly System.Windows.Forms
$result = [System.Windows.Forms.MessageBox]::Show("BlockedAndMuted.txt を出力しました")
