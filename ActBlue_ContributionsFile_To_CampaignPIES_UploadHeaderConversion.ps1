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
Write-Verbose -Verbose "Establish header...";
$ActBlueAllContributionsHeader = @("Receipt ID","Date","Amount","Recurring Total Months","Recurrence Number","Recipient","Fundraising Page","Fundraising Partner","Reference Code 2","Reference Code","Donor First Name","Donor Last Name","Donor Addr1","Donor Addr2","Donor City","Donor State","Donor ZIP","Donor Country","Donor Occupation","Donor Employer","Donor Email","Donor Phone","New Express Signup","Comments","Check Number","Check Date","Employer Addr1","Employer Addr2","Employer City","Employer State","Employer ZIP","Employer Country","Donor ID","Fundraiser ID","Fundraiser Recipient ID","Fundraiser Contact Email","Fundraiser Contact First Name","Fundraiser Contact Last Name","Partner ID","Partner Contact Email","Partner Contact First Name","Partner Contact Last Name","Reserved_01","Lineitem ID","AB Test Name","AB Variation","Recipient Committee","Recipient ID","Recipient Gov ID","Recipient Election","Reserved_02","Payment ID","Payment Date","Disbursement ID","Disbursement Date","Recovery ID","Recovery Date","Refund ID","Refund Date","Fee","Recur Weekly","ActBlue Express Lane","Reserved_03","Card Type","Reserved_04","Reserved_05","Reserved_06","Reserved_07","Mobile","Recurring Upsell Shown","Recurring Upsell Succeeded","Double Down","Smart Recurring","Monthly Recurring Amount","Apple Pay","Card Replaced by Account Updater","ActBlue Express Donor","Custom Field 1 Label","Custom Field 1 Value","Donor US Passport Number","Text Message Opt In","Gift Identifier","Gift Declined","Shipping Addr1","Shipping City","Shipping State","Shipping Zip","Shipping Country","Weekly Recurring Amount","Smart Boost Amount","Smart Boost Shown");

Write-Verbose -Verbose "Process file..."
Get-Content $FullName |Select-Object -Skip 1 | ConvertFrom-Csv -Header $ActBlueAllContributionsHeader `
| Select-Object @{name="first_name";expression={$_."Donor First Name"}}`
,@{name="last_name";expression={$_."Donor Last Name"}}`
,@{name="email";expression={$_."Donor Email"}}`
,@{name="amount";expression={$_."Amount"}}`
,@{name="date";expression={$_."Date"}}`
,@{name="payment_id";expression={$_."Payment ID"}}`
| Export-Csv -NoTypeInformation -Path $file.FullName.Replace($file.Extension,"_CampaignPiesHeaders.csv");

}<# END PROCESS  #>
END     {}<# END END      #>

 


