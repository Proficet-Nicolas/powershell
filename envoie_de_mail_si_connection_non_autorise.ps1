#================================================================================================
#Script permettant de recevoir un message d'alerte si une connection non autorisé est effectué sur le serveur
#================================================================================================


#Récupération du message de l'évènement correspondant à une authentification d'utilisateur réussie et création d'un fichier texte test.txt recueillant les données récupéré 
$Log = Get-WinEvent -FilterHashTable @{LogName='Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational';ID='1149'} | Format-Table -wrap -Property message > C:\test.txt

#Récupération de l'évènement complet correspondant à une authentification d'utilisateur réussie et création d'un fichier texte fullLog.txt recueillant les données récupéré 
$fLog = Get-WinEvent -FilterHashTable @{LogName='Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational';ID='1149'} | Format-Table -wrap > C:\fullLog.txt

#Variable qui va lire les informations contenue dans le fichier texte fullLog.txt
$fLog = [IO.File]::ReadAllText("C:\fullLog.txt")

#Variable récupérant la chaîne de caractère correspondant à l'évènement complet lors de la connection d'un utilisateur
$fullLog = $fLog.Substring(0, 950)

#Variable qui va lire les informations contenue dans le fichier texte test.txt
$content = [IO.File]::ReadAllText("C:\test.txt")

#Variable récupérant la chaîne de caractère correspondant à l'utilisateur qui c'est connecté
$data = $content.Substring(416, 4)
$data1 = $content.Substring(416, 5)
$data2 = $content.Substring(416, 6)
$data3 = $content.Substring(416, 7)
$data4 = $content.Substring(416, 8)
$data5 = $content.Substring(416, 9)
$data6 = $content.Substring(416, 10)
$data7 = $content.Substring(416, 11)
$data8 = $content.Substring(416, 12)
$data9 = $content.Substring(416, 13)
$data10 = $content.Substring(416, 14)
$data11 = $content.Substring(416, 15)

#Variable indiquant les personnes pouvant se connecter au serveur
$Users = "user1"
$Users1 = "user2"
$Users2 = "user3"

#Variable indiquant le chemin d'accès vers le fichier texte
$filepath = "C:\log.txt"

#Si la variable data est égale à la variable Users l'utilisateur est connecté et un message disant que la connexion est valide est écrit dans un fichier texte et affiché dans la console
if (($data,$data1,$data2,$data3,$data4,$data5,$data6,$data7,$data8,$data9,$data10,$data11 -eq $Users) -or ($data,$data1,$data2,$data3,$data4,$data5,$data6,$data7,$data8,$data9,$data10,$data11 -eq $Users1)-or ($data,$data1,$data2,$data3,$data4,$data5,$data6,$data7,$data8,$data9,$data10,$data11 -eq $Users2))
{
    Add-Content -Path $filepath -Value ($fulllog, "Connexion valide")
    Get-Content $filepath | foreach {write-host $_}
}
#Sinon un message d'alerte est écrit dans un fichier texte et affiché dans la console
else
{
    Add-Content -Path $filepath -Value ($fulllog, "Une connexion non autorisé à été détecté")
    Get-Content $filepath | foreach {write-host $_}
}  