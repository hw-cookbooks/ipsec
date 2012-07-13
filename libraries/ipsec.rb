module IPSec
  def self.bits(dot)
    bits   = 0
    octets = dot.split('.').map {|p| p.to_i }
    octets.each do |octet|
      unless octet == 0
        bits += Math.log10(octet + 1) / Math.log10(2)
      end
    end
    bits.to_i
  end

  def self.dot_to_long(dot)
    octets = dot.split('.').map {|p| p.to_i }
    long   = octets[0] << 24
    long  += octets[1] << 16
    long  += octets[2] << 8
    long  += octets[3]
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
          unless [node[:ipaddress], "127.0.0.1"].include?(address)
            subnets << subnet(address, address_details[:netmask]) + "/" + bits(address_details[:netmask])
          end
        end
      end
    end
    subnets.join(" ")
  end
end
