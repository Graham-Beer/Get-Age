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
    
    # is it a leap year ?
    switch ([datetime]::IsLeapYear($cDate.Year))
    {
        $true  { [int]$daysInYear = '366' }
        $false { [int]$daysInYear = '365' }
    }

    # Work out Years, months and days
    
    # years
    $totalYears = [math]::Truncate( $($diff.Days) / $daysInYear ) 
    
    <# months 
    30 is the average days in a month
    365 / 12 = 30.4166666666667 
    [math]::Round(365 / 12) is 30 #>
    $totalMonths = [math]::Truncate( $($diff.Days) % $daysInYear / [int]30 ) 
    
    # days
    $remainingDays = [math]::Truncate( $($diff.Days) % $daysInYear % [int]30 ) 

    # Work out how many days until birthday    
    $now = [DateTime]::Now   
    $dm = get-date $Bday -UFormat "%m/%d/" 
    $Days = [Datetime]($dm + $now.Year) – $Now    
}
        
End {
    # display
    "`nYou are {0} year(s), {1} month(s) and {2} day(s)" -f $totalYears, $totalMonths, $remainingDays
    
    # and...
    if ($cDate.Year -eq (get-date).Year) { 
        "You have another $($daysInYear - $diff.Days) days until your birthday" # If you are under 1 years old
    } else { 
        "You have another $($Days.days) days until your birthday" # over the age of 1 
    }
    
}

}# Function End