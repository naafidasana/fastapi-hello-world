terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 3.0.0"
        }
    }
}


provider "azurerm" {
    features {}
}


resource "azurerm_resource_group" "cloud_computing_course_rg" {
    name = "fastapi-rg"
    location = "francecentral"
}

resource "azurerm_service_plan" "hello_world_sp" {
    name = "hello-world-sp"
    location = azurerm_resource_group.cloud_computing_course_rg.location
    resource_group_name = azurerm_resource_group.cloud_computing_course_rg.name
    os_type = "Linux"
    sku_name = "B1"
}


resource "azurerm_linux_web_app" "hello_world_app" {
    name = "fastapi-app-service"
    location = azurerm_resource_group.cloud_computing_course_rg.location
    resource_group_name = azurerm_resource_group.cloud_computing_course_rg.name
    service_plan_id = azurerm_service_plan.hello_world_sp.id
    https_only = true

    site_config {}

    app_settings = {
        "WEBSITE_RUN_FROM_PACKAGE" = "1"
    }
}