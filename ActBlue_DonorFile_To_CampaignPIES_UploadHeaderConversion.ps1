PARAM(

[Parameter(Mandatory= $true,ValueFromPipelineByPropertyName= $true)]
[ValidateNotNullorEmpty()][ValidateScript({
            IF (Test-Path -PathType leaf -Path $_ ) 
                {$True}
            ELSE {
                Throw "$_ is not a file."
            } 
        })][String]$FullName
,[Parameter(Mandatory= $true,ValueFromPipelineByPropertyName= $true)][String]$LoadName
,[Parameter(Mandatory= $true,ValueFromPipelineByPropertyName= $true)][String]$GroupName
)

BEGIN   {}<# END BEGIN    #>
PROCESS {

[System.IO.FileInfo]$file = Get-ChildItem $FullName;

Import-Csv $FullName | Select-Object @{name="first_name";expression={$_."Donor First Name"}}`
,@{name="last_name";expression={$_."Donor Last Name"}}`
,@{name="email";expression={$_."Donor Email"}}`
,@{name="home_phone";expression={$null}}`
,@{name="work_phone";expression={$null}}`
,@{name="mobile_phone";expression={$null}}`
,@{name="unspecified_phone";expression={$_."Donor Phone"}}`
,@{name="occupation";expression={$_."Donor Occupation"}}`
,@{name="employer";expression={$_."Donor Employer"}}`
,@{name="salutation";expression={$null}}`
,@{name="default_ask";expression={$null}}`
,@{name="donor_priority";expression={$_.""}}`
,@{name="address1";expression={$_."Donor Addr1"}}`
,@{name="city";expression={$_."Donor City"}}`
,@{name="state";expression={$_."Donor State"}}`
,@{name="zip";expression={$_."Donor ZIP"}}`
,@{name="notes";expression={$null}}`
,@{name="donor_likelihood_grade";expression={$null}}`
,@{name="donor_amount_grade";expression={$null}}`
,@{name="custom_field_1";expression={$null}}`
,@{name="custom_field_2";expression={$null}}`
,@{name="custom_field_3";expression={$null}}`
,@{name="custom_field_4";expression={$null}}`
,@{name="custom_field_5";expression={$null}}`
,@{name="custom_field_6";expression={$null}}`
,@{name="custom_field_7";expression={$null}}`
,@{name="custom_field_8";expression={$LoadName}}`
,@{name="custom_field_9";expression={$GroupName}}`
| Export-Csv -NoTypeInformation -Path $file.FullName.Replace($file.Extension,"_CampaignPiesHeaders.csv");

}<# END PROCESS  #>
END     {}<# END END      #>

