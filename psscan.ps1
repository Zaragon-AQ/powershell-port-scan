param(
    [Parameter(Mandatory=$true)][string] $machinesList,
    [Parameter(Mandatory=$true)][string] $port
)


$ComputerName = $machinesList.Split(",")
$sourceMachineName = [System.Net.Dns]::GetHostName();

foreach ($Computer in $ComputerName) {


    # Create a Net.Sockets.TcpClient object to use for
    # checking for open TCP ports.
    $Socket = New-Object Net.Sockets.TcpClient

    # Suppress error messages
    $ErrorActionPreference = 'SilentlyContinue'

    # Try to connect
    $Socket.Connect($Computer, $port)

    # Make error messages visible again
    $ErrorActionPreference = 'Continue'

    # Determine if we are connected.
    if ($Socket.Connected) {
        "From ${sourceMachineName} to ${Computer}: Port $port is open"
        $Socket.Close()
    }
    else {
        "From ${sourceMachineName} to ${Computer}: Port $port is closed or filtered"  
    }
    # Apparently resetting the variable between iterations is necessary.
    $Socket = $null
    
}
