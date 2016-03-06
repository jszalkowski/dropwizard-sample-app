# sample-app cookbook

## Sviluppo

### Requisiti

1. [Chef Development Kit](https://downloads.getchef.com/chef-dk/)
2. [VirtualBox](https://www.virtualbox.org/)
3. [Vagrant](https://www.vagrantup.com/)

Plugin vagrant
```
vagrant plugin install vagrant-berkshelf
vagrant plugin install vagrant-proxyconf
vagrant plugin install vagrant-cachier
```

### Test

Esecuzione test unitari
```
chef exec rspec
```

Esecuzione test di integrazione (creazione e distruzione macchina virtuale)
```
kitchen test
```

Creazione macchina di test e provisioning
```
kitchen create
kitchen converge
```

Esecuzione test di integrazione
```
kitchen verify
```

Login nella macchina di test
```
kitchen login
```
