module IPSec
  def self.dot_to_long(dot)
    pieces = dot.split('.').map {|p| p.to_i }
    long   = pieces[0] << 24
    long  += pieces[1] << 16
    long  += pieces[2] << 8
    long  += pieces[3]
  end

  def self.subnet(ip, netmask)
    smashed   = dot_to_long(ip) & dot_to_long(netmask)
    octets    = []
    octets[0] = (smashed & 0xFF000000) >> 24
    octets[1] = (smashed & 0x00FF0000) >> 16
    octets[2] = (smashed & 0x0000FF00) >> 8
    octets[3] = (smashed & 0x000000FF)
    octets.join('.')
  end

  def self.get_subnets(node)
    subnets = []
    node[:network][:interfaces].each_value do |interface_details|
      interface_details[:addresses].each do |address, address_details|
        if address_details[:family] == "inet"
          unless address == node[:ipaddress]
            subnets << subnet(address, address_details[:netmask])
          end
        end
      end
    end
    subnets.join(" ")
  end
end
