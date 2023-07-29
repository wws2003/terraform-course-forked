
data "cloudinit_config" "app_cloudinit_config" {

  gzip          = false
  base64_encode = false

    # Filling device to template: init_scripts.sh
    part {
        // Inject $DEVICE into init_scripts.sh
        content_type = "text/x-shellscript"
        content      = templatefile("scripts/init_scripts.sh", {
            DEVICE = var.INSTANCE_DEVICE_NAME
        })
    }
    
    # Filling region to template: init.cfg
    part {
        filename     = "init.cfg"
        content_type = "text/cloud-config"
        content      = templatefile("scripts/init.cfg", {
            REGION = var.AWS_REGION
        })
    }
}