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

    # Work out Years, months and days
    [int]$daysInYear = '365'
    [int]$averageMonth = '30'
      
    # years
    $totalYears = [math]::Truncate( $($diff.Days) / $daysInYear ) 
    
    <# months 
    30 is the average days in a month
    365 / 12 = 30.4166666666667 
    [math]::Truncate(365 / 12) is 30 #>
    $totalMonths = [math]::Truncate( $($diff.Days) % $daysInYear / $averageMonth ) 
    
    # days
    $remainingDays = [math]::Truncate( $($diff.Days) % $daysInYear % $averageMonth ) 

    # Your star sign
    $thisYear = (get-date).Year
     
    $starSign = 
    switch ($cDate.DayOfYear) {
    
        { $_ -in @( ((get-date 22/12/$thisYear).DayOfYear)..365; 0..((get-date 19/01/$thisYear).DayOfYear) ) } { "Capricorn" }
        { $_ -in @( ((get-date 20/01/$thisYear).DayOfYear)..((get-date 18/02/$thisYear).DayOfYear) ) } { "Aquarius" }
        { $_ -in @( ((get-date 19/02/$thisYear).DayOfYear)..((get-date 20/03/$thisYear).DayOfYear) ) } { "Pisces" }
        { $_ -in @( ((get-date 21/03/$thisYear).DayOfYear)..((get-date 19/04/$thisYear).DayOfYear) ) } { "Aries" }
        { $_ -in @( ((get-date 20/04/$thisYear).DayOfYear)..((get-date 20/05/$thisYear).DayOfYear) ) } { "Taurus" }
        { $_ -in @( ((get-date 21/05/$thisYear).DayOfYear)..((get-date 20/06/$thisYear).DayOfYear) ) } { "Gemini" }
        { $_ -in @( ((get-date 21/06/$thisYear).DayOfYear)..((get-date 22/07/$thisYear).DayOfYear) ) } { "Cancer" }
        { $_ -in @( ((get-date 23/07/$thisYear).DayOfYear)..((get-date 22/08/$thisYear).DayOfYear) ) } { "Leo" }
        { $_ -in @( ((get-date 23/08/$thisYear).DayOfYear)..((get-date 22/09/$thisYear).DayOfYear) ) } { "Virgo" }
        { $_ -in @( ((get-date 23/09/$thisYear).DayOfYear)..((get-date 22/10/$thisYear).DayOfYear) ) } { "Libra" }
        { $_ -in @( ((get-date 23/10/$thisYear).DayOfYear)..((get-date 21/11/$thisYear).DayOfYear) ) } { "Scorpio" }
        { $_ -in @( ((get-date 22/10/$thisYear).DayOfYear)..((get-date 21/12/$thisYear).DayOfYear) ) } { "Sagittarius" }
    } 
    
    # Work out how many days until birthday    
    $now = [DateTime]::Now   
    $dm = get-date $Bday -UFormat "%m/%d/" 
    $Days = [Datetime]($dm + $now.Year) – $Now    
}
        
End {
    # display
    "`nYou are {0} year(s), {1} month(s) and {2} day(s)" -f $totalYears, $totalMonths, $remainingDays
    "Your Star sign is: " + $starSign
    
    # and...
    if ($cDate.Year -eq (get-date).Year) { 
        "You have another $($daysInYear - $diff.Days) days until your birthday" # If you are under 1 years old
    } else { 
        "You have another $($Days.days) days until your birthday" # over the age of 1 
    }
    
}

}# Function End