module ApplicationHelper
  def get_ip_address
    ip=Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
    ip.ip_address if ip
  end
end
