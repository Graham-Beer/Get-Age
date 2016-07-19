function Get-age {

    param( 
        [Parameter(Mandatory=$true,
                   HelpMessage="Date must be written as dd/mm/yy",
                   Position=0)]
        [ValidatePattern("^(0[1-9]|[12]\d|3[01])/(0[1-9]|1[0-2])/(\d{2})$")]
        [ValidateLength(0,8)]
        [string]$Bday    
    )


Begin {
# use 'get-date' to convert '$Bday' Variable
$cDate = (get-date -Date $Bday)

# from today's date subtract birth date
$diff = (Get-Date).Subtract($cDate)
}

Process {

    if ($diff.Days -le 365) {
        
        # comment to host
        "`nyou are only $($diff.Days) days old !`nYou have another $([int]365 - $diff.Days) days until your birthday" 
    
    } else {
    
    <#
    // description of below code in steps //

    1. round up age in years and months
    2. split year and months
    3. obtain current date and time
    4. display day and month but remove year .i.e 09/16/
    5. add the current year onto birthday day and month then subtract from now to obtain how many days until birthday
    #>
  
    <#1.#> $age = [math]::Round( (($diff).days / 365), 1 )
    
    <#2.#> $year,$months = $age.tostring().split('.') 
    
    <#3.#> $now = [DateTime]::Now 
    
    <#4.#> $dm = get-date $Bday -UFormat "%m/%d/" 
    
    <#5.#> $Days = [Datetime]($dm + $now.Year) – $Now

    # comment to host
    "`nYou are $year and $months months old`nYou have another $($Days.days) days until your birthday"
    }
}

End {}

}# Function End