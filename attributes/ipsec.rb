default[:ipsec][:nat_traversal] = 'yes'
default[:ipsec][:shared_secret] = 'my_insecure_secret'
default[:ipsec][:connection_type] = 'host-host'
default[:ipsec][:charon][:modules] = %w(
  aes des sha1 sha2 md5 pem pkcs1 gmp random hmac
  xcbc stroke kernel-netlink socket-default updown
)
default[:ipsec][:charon][:multiple_authentication] = 'no'
