name              "printers"
maintainer        "David Amian"
maintainer_email  "damian@emergya.com"
license           "Apache 2.0"
description       "Set printers to node"
version           "0.1.1"

recipe            "printers::printers", "Set printers to node"

%w{ ubuntu debian }.each do |os|
  supports os
end

