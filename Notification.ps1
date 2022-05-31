Function Send-Telegram {
	Param(
		[Parameter(Mandatory=$true)]
		[String]$chatId,

		[Parameter(Mandatory=$true)]
		[String]$Message
	)
	Add-Type -AssemblyName System.Web
	$msg = ([System.Web.HttpUtility]::UrlEncode($Message))
	$msg = $msg.Replace("%5bok%5d","%E2%9C%85").Replace("%5bnok%5d","%E2%9D%8C")
	(curl.exe -s --proxy http://165.225.200.15:80 -X POST "https://api.telegram.org/bot$(get-content -path 'token.txt')/sendMessage?chat_id=$chatId&text=$msg") > $null
}
if($args.Count -gt 0){
    foreach($user in Get-content "users.txt"){
        Send-Telegram -Message $args[0] -chatId $user
    }
}
else{
	"Not enough arguments, need the first one to be the message."
}