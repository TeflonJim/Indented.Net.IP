InModuleScope 'Indented.Net.IP' {
    Describe 'Get-Subnets' {
        It 'Returns an object tagged with the type Indented.Net.IP.Subnet' {
            $Subnets = Get-Subnets 0/24 -NewSubnetMask 25
            $Subnets[0].PSTypeNames -contains 'Indented.Net.IP.Subnet' | Should Be $true
        }
        
        It 'Creates two /26 subnets from 10/25' {
            $Subnets = Get-Subnets 10/25 -NewSubnetMask 26
            $Subnets[0].NetworkAddress | Should Be '10.0.0.0'
            $Subnets[1].NetworkAddress | Should Be '10.0.0.64'
        }
        
        It 'Handles both subnet mask and mask length formats for NewSubnetMask' {
            $Subnets = Get-Subnets 10/24 -NewSubnetMask 26
            $Subnets.Count | Should Be 4

            $Subnets = Get-Subnets 10/24 -NewSubnetMask 255.255.255.192
            $Subnets.Count | Should Be 4
        }
        
        It 'Throws an error if requested to subnet a smaller network into a larger one' {
            { Get-Subnets 0/24 -NetSubnetMask 23 } | Should Throw
        }
        
        It 'Has valid examples' {
            (Get-Help Get-Subnets).Examples.Example.Code | ForEach-Object {
                $ScriptBlock = [ScriptBlock]::Create($_.Trim())
                $ScriptBlock | Should Not Throw
            }
        }
    }
}