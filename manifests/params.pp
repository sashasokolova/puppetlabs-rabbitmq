  # Class: rabbitmq::params
#
#   The RabbitMQ Module configuration settings.
#
class rabbitmq::params {
  
  include pkgng
  #pkgng required binaries: /usr/local/sbin/pkg
  file { '/usr/local/sbin/pkg':
       ensure => 'link',
       target => '/usr/sbin/pkg',
  } 
 
  case $::osfamily {
    'Archlinux': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq'
      $service_name     = 'rabbitmq'
      $version          = '3.1.3-1'
      $rabbitmq_user    = 'rabbitmq'
      $rabbitmq_group   = 'rabbitmq'
      $rabbitmq_home    = '/var/lib/rabbitmq'
      $plugin_dir       = "/usr/lib/rabbitmq/lib/rabbitmq_server-${version}/plugins"
    }
    'Debian': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq-server'
      $service_name     = 'rabbitmq-server'
      $package_provider = 'apt'
      $version          = '3.1.5'
      $rabbitmq_user    = 'rabbitmq'
      $rabbitmq_group   = 'rabbitmq'
      $rabbitmq_home    = '/var/lib/rabbitmq'
      $plugin_dir       = "/usr/lib/rabbitmq/lib/rabbitmq_server-${version}/plugins"
    }
    'OpenBSD': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq'
      $service_name     = 'rabbitmq'
      $version          = '3.4.2'
      $rabbitmq_user    = '_rabbitmq'
      $rabbitmq_group   = '_rabbitmq'
      $rabbitmq_home    = '/var/rabbitmq'
      $plugin_dir       = '/usr/local/lib/rabbitmq/plugins'
    }
    'RedHat': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq-server'
      $service_name     = 'rabbitmq-server'
      $package_provider = 'yum'
      $version          = '3.1.5-1'
      $rabbitmq_user    = 'rabbitmq'
      $rabbitmq_group   = 'rabbitmq'
      $rabbitmq_home    = '/var/lib/rabbitmq'
      $plugin_dir       = "/usr/lib/rabbitmq/lib/rabbitmq_server-${version}/plugins"
    }
    'SUSE': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq-server'
      $service_name     = 'rabbitmq-server'
      $package_provider = 'zypper'
      $version          = '3.1.5-1'
      $rabbitmq_user    = 'rabbitmq'
      $rabbitmq_group   = 'rabbitmq'
      $rabbitmq_home    = '/var/lib/rabbitmq'
      $plugin_dir       = "/usr/lib/rabbitmq/lib/rabbitmq_server-${version}/plugins"
    }
    'FreeBSD': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq'
      $service_name     = 'rabbitmq'
      $package_provider = 'pkgng'
      $version          = '3.6.5'
      $rabbitmq_user    = 'rabbitmq'
      $rabbitmq_group   = 'rabbitmq'
      $rabbitmq_home    = '/var/db/rabbitmq'
      $plugin_dir       = "/usr/local/lib/erlang/lib/rabbitmq_server-${version}/plugins"
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
     }
    require => File['/usr/local/sbin/pkg'],
  }

  #install
  case $::osfamily {
    'FreeBSD': {
      $admin_enable           = false
      $repos_ensure           = false
      $config_path            = '/usr/local/etc/rabbitmq/rabbitmq.config'
      $env_config_path        = '/usr/local/etc/rabbitmq/rabbitmq-env.conf'
    }
    default: {
      $admin_enable           = true
      $repos_ensure           = true
      $config_path            = '/etc/rabbitmq/rabbitmq.config'
      $env_config_path        = '/etc/rabbitmq/rabbitmq-env.conf'
    }
  }
  $management_port            = '15672'
  $management_ssl             = true
  $package_apt_pin            = ''
  $package_gpg_key            = 'http://www.rabbitmq.com/rabbitmq-signing-key-public.asc'
  $manage_repos               = undef
  $service_ensure             = 'running'
  $service_manage             = true
  #config
  $cluster_node_type          = 'disc'
  $cluster_nodes              = []
  $config                     = 'rabbitmq/rabbitmq.config.erb'
  $config_cluster             = false
  $config_stomp               = false
  $default_user               = 'guest'
  $default_pass               = 'guest'
  $delete_guest_user          = false
  $env_config                 = 'rabbitmq/rabbitmq-env.conf.erb'
  $erlang_cookie              = undef
  $interface                  = 'UNSET'
  $node_ip_address            = 'UNSET'
  $port                       = '5672'
  $tcp_keepalive              = false
  $ssl                        = false
  $ssl_only                   = false
  $ssl_cacert                 = 'UNSET'
  $ssl_cert                   = 'UNSET'
  $ssl_key                    = 'UNSET'
  $ssl_port                   = '5671'
  $ssl_interface              = 'UNSET'
  $ssl_management_port        = '15671'
  $ssl_stomp_port             = '6164'
  $ssl_verify                 = 'verify_none'
  $ssl_fail_if_no_peer_cert   = false
  $ssl_versions               = undef
  $ssl_ciphers                = []
  $stomp_ensure               = false
  $ldap_auth                  = false
  $ldap_server                = 'ldap'
  $ldap_user_dn_pattern       = 'cn=username,ou=People,dc=example,dc=com'
  $ldap_other_bind            = 'anon'
  $ldap_use_ssl               = false
  $ldap_port                  = '389'
  $ldap_log                   = false
  $ldap_config_variables      = {}
  $stomp_port                 = '6163'
  $stomp_ssl_only             = false
  $wipe_db_on_cookie_change   = false
  $cluster_partition_handling = 'ignore'
  $environment_variables      = {}
  $config_variables           = {}
  $config_kernel_variables    = {}
  $file_limit                 = '16384'
}
