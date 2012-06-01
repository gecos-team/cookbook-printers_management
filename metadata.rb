name              "printers_management"
maintainer        "David Amian"
maintainer_email  "damian@emergya.com"
license           "Apache 2.0"
description       "Set printers to node"
version           "0.1.2"

recipe            "printers_management::manual_printers", "Set printers to node"
recipe            "printers_management::automatic_printers", "Set predefined printers to node"

%w{ ubuntu debian }.each do |os|
  supports os
end

attribute 'automatic_printers/printers_spa',
  :display_name => "Printers",
  :description  => "List of printers",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'printers_management::automatic_printers' ]
  
attribute 'automatic_printers/printers_spa/name',
  :display_name => "Printers",
  :description  => "List of available printers",
  :type         => "string",
  :required     => "required",
  :wizard       => "selector",
  :source       => "available_printers",
  :order        => "0",
  :recipes      => [ 'printers_management::automatic_printers' ]

attribute 'manual_printers/printers',
  :display_name => "Printers",
  :description  => "List of printers",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'printers_management::manual_printers' ]


attribute 'manual_printers/printers/name',
  :display_name => "Printer name",
  :description  => "Set a description for this printer",
  :type         => "string",
  :required     => "required",
  :order        => "0",
  :recipes      => [ 'printers_management::manual_printers' ]

attribute 'manual_printers/printers/make',
  :display_name => "Printer manufacturer",
  :description  => "Set the printer brand name",
  :type         => "string",
  :required     => "required",
  :order        => "1",
  :recipes      => [ 'printers_management::manual_printers' ]

attribute 'manual_printers/printers/model',
  :display_name => "Printer model name",
  :description  => "Set the printer model",
  :type         => "string",
  :required     => "required",
  :order        => "2",
  :recipes      => [ 'printers_management::manual_printers' ]

attribute 'manual_printers/printers/ppd',
  :display_name => "PPD file",
  :description  => "Set the Postscript Printer Definition (PPD) destination file name (how file will be named in the workstation)",
  :type         => "string",
  :order        => "3",
  :recipes      => [ 'printers_management::manual_printers' ]

attribute 'manual_printers/printers/ppd_uri',
  :display_name => "PPD URI",
  :description  => "Set this URI to download a PPD file",
  :type         => "string",
  :order        => "4",
  :validation   => "url",
  :recipes      => [ 'printers_management::manual_printers' ]

attribute 'manual_printers/printers/uri',
  :display_name => "Printer URI",
  :description  => "Set the printer Universal Resource Identifier (URI)",
  :type         => "string",
  :required     => "required",
  :order        => "5",
  :validation   => "printer_uri",
  :recipes      => [ 'printers_management::manual_printers' ]
