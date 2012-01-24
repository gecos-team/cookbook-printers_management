name              "printers"
maintainer        "David Amian"
maintainer_email  "damian@emergya.com"
license           "Apache 2.0"
description       "Set printers to node"
version           "0.1.1"

recipe            "printers::printers", "Set printers to node"
recipe            "printers::printers_spa", "Set printers to node"

%w{ ubuntu debian }.each do |os|
  supports os
end

attribute 'printers_spa/printers_spa',
  :display_name => "Printers",
  :description  => "List of printers",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'printers::printers_spa' ]
  
attribute 'printers_spa/printers_spa/name',
  :display_name => "Printers",
  :description  => "List of available printers",
  :type         => "string",
  :required     => "required",
  :wizard       => "selector",
  :source       => "available_printers",
  :order        => "0",
  :recipes      => [ 'printers::printers_spa' ]

attribute 'printers/printers',
  :display_name => "Printers",
  :description  => "List of printers",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'printers::printers' ]


attribute 'printers/printers/name',
  :display_name => "Printer name",
  :description  => "Set a description for this printer",
  :type         => "string",
  :required     => "required",
  :order        => "0",
  :recipes      => [ 'printers::printers' ]

attribute 'printers/printers/make',
  :display_name => "Printer manufacturer",
  :description  => "Set the printer brand name",
  :type         => "string",
  :required     => "required",
  :order        => "1",
  :recipes      => [ 'printers::printers' ]

attribute 'printers/printers/model',
  :display_name => "Printer model name",
  :description  => "Set the printer model",
  :type         => "string",
  :required     => "required",
  :order        => "2",
  :recipes      => [ 'printers::printers' ]

attribute 'printers/printers/ppd',
  :display_name => "PPD file",
  :description  => "Set the Postscript Printer Definition (PPD) file name",
  :type         => "string",
  :order        => "3",
  :recipes      => [ 'printers::printers' ]

attribute 'printers/printers/ppd_uri',
  :display_name => "PPD URI",
  :description  => "Set this URI to download a PPD file",
  :type         => "string",
  :order        => "4",
  :validation   => "url",
  :recipes      => [ 'printers::printers' ]

attribute 'printers/printers/uri',
  :display_name => "Printer URI",
  :description  => "Set the printer Universal Resource Identifier (URI)",
  :type         => "string",
  :required     => "required",
  :order        => "5",
  :validation   => "printer_uri",
  :recipes      => [ 'printers::printers' ]
