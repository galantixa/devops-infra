//TODO Create Group
resource "azurerm_resource_group" "galantixa" {
    name     = "galanixa-resources"
    location = "Southeast Asia"
    tags = {
        environment = "Production"
    }
}

//TODO Create Vpc & Subnet
resource "azurerm_virtual_network" "default" {
    name                = "vpcNet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.galantixa.location
    resource_group_name = azurerm_resource_group.galantixa.name
}

resource "azurerm_subnet" "galantixa-subnet" {
    name                 = "subnet-galantixa"
    resource_group_name  = azurerm_resource_group.galantixa.name
    virtual_network_name = azurerm_virtual_network.default.name
    address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "galantixa-sg" {
    name                 = "vm-sg"
    location             = azurerm_resource_group.galantixa.location
    resource_group_name  = azurerm_resource_group.galantixa.name
}
//TODO Firewall
resource "azurerm_network_security_rule" "firewall" {
    name                        = "security-rules"
    priority                    = 100
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.galantixa.name
    network_security_group_name = azurerm_network_security_group.galantixa-sg.name
}
//TODO Asign public IP
resource "azurerm_public_ip" "ip-appserver" {
    name                = "app-ip"
    resource_group_name = azurerm_resource_group.galantixa.name
    location            = azurerm_resource_group.galantixa.location
    allocation_method   = "Static"

    tags = {
        environment = "Production"
    }   
}

resource "azurerm_public_ip" "ip-gateway" {
    name                = "gateway-ip"
    resource_group_name = azurerm_resource_group.galantixa.name
    location            = azurerm_resource_group.galantixa.location
    allocation_method   = "Static"

    tags = {
        environment = "Production"
    }   
}

resource "azurerm_public_ip" "ip-monitoring" {
    name                = "monitoring-ip"
    resource_group_name = azurerm_resource_group.galantixa.name
    location            = azurerm_resource_group.galantixa.location
    allocation_method   = "Static"

    tags = {
        environment = "Production"
    }   
}

//TODO Setup Nic
resource "azurerm_network_interface" "appserver-nic" {
    name                = "appserver-nic"
    location            = azurerm_resource_group.galantixa.location
    resource_group_name = azurerm_resource_group.galantixa.name

    ip_configuration {
        name                          = "internal-appserver"
        subnet_id                     = azurerm_subnet.galantixa-subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.ip-appserver.id
    }

    tags = {
        environment = "Production"
    }
} 

resource "azurerm_network_interface" "gateway-nic" {
    name                = "galantixa-nic"
    location            = azurerm_resource_group.galantixa.location
    resource_group_name = azurerm_resource_group.galantixa.name

    ip_configuration {
        name                          = "internal-gateway"
        subnet_id                     = azurerm_subnet.galantixa-subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.ip-gateway.id
    }

    tags = {
        environment = "Production"
    }
}

resource "azurerm_network_interface" "monitoring-nic" {
    name                = "monitoring-nic"
    location            = azurerm_resource_group.galantixa.location
    resource_group_name = azurerm_resource_group.galantixa.name

    ip_configuration {
        name                          = "internal-monitoring"
        subnet_id                     = azurerm_subnet.galantixa-subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.ip-monitoring.id
    }

    tags = {
        environment = "Production"
    }
}
//TODO Create Vm's
resource "azurerm_linux_virtual_machine" "appserver" {
    name                = "appserver"
    resource_group_name = azurerm_resource_group.galantixa.name
    location            = azurerm_resource_group.galantixa.location
    size                = "Standard_B2ms"
    admin_username      = "adminuser"
    admin_password      = "celaluCayank123!" 
    network_interface_ids = [azurerm_network_interface.appserver-nic.id]

    admin_ssh_key {
        username = "adminuser"
        public_key = file("/home/fanboy/.ssh/id_rsa.pub")
    }
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-focal"
        sku       = "20_04-lts"
        version   = "latest"
    }

    computer_name  = "appserver"
}

resource "azurerm_linux_virtual_machine" "gateway" {
    name                = "gateway"
    resource_group_name = azurerm_resource_group.galantixa.name
    location            = azurerm_resource_group.galantixa.location
    size                = "Standard_B1s"
    admin_username      = "adminuser"
    admin_password      = "celaluCayank123!" 
    network_interface_ids = [azurerm_network_interface.gateway-nic.id]

    admin_ssh_key {
        username = "adminuser"
        public_key = file("/home/fanboy/.ssh/id_rsa.pub")
    }
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-focal"
        sku       = "20_04-lts"
        version   = "latest"
    }

    computer_name  = "gateway"
}

resource "azurerm_linux_virtual_machine" "monitoring" {
    name                = "monitoring"
    resource_group_name = azurerm_resource_group.galantixa.name
    location            = azurerm_resource_group.galantixa.location
    size                = "Standard_DS1_v2"
    admin_username      = "adminuser"
    admin_password      = "celaluCayank123!" 
    network_interface_ids = [azurerm_network_interface.monitoring-nic.id]

    admin_ssh_key {
        username = "adminuser"
        public_key = file("/home/fanboy/.ssh/id_rsa.pub")
    }
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-focal"
        sku       = "20_04-lts"
        version   = "latest"
    }

    computer_name  = "monitoring"
}