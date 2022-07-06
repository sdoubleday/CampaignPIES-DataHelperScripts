PARAM(

[Parameter(Mandatory= $true,ValueFromPipelineByPropertyName= $true)]
[ValidateNotNullorEmpty()][ValidateScript({
            IF (Test-Path -PathType leaf -Path $_ ) 
                {$True}
            ELSE {
                Throw "$_ is not a file."
            } 
        })][String]$FullName
)

BEGIN   {}<# END BEGIN    #>
PROCESS {

[System.IO.FileInfo]$file = Get-ChildItem $FullName;

Import-Csv $FullName | Select-Object @{name="First Name";expression={$_."Donor First Name"}}`
,@{name="Last Name";expression={$_."Donor Last Name"}}`
,@{name="Email";expression={$_."Donor Email"}}`
,@{name="Zip";expression={$_."Donor ZIP"}}`
,@{name="Address";expression={$_."Donor Addr1"}}`
,@{name="Phone";expression={$_."Donor Phone"}}`
,@{name="Birthday";expression={$null}}`
| Export-Csv -NoTypeInformation -Path $file.FullName.Replace($file.Extension,"_CampaignPiesEmailBlasterHeaders.csv");

}<# END PROCESS  #>
END     {}<# END END      #>

