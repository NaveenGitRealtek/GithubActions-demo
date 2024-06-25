# #!/bin/bash

# # Calculate the version number based on the GitHub Actions run number
# VERSION="V0.0.$GITHUB_RUN_NUMBER"
# echo $VERSION

#!/bin/bash

# Calculate the version number based on the GitHub Actions run number
VERSION="v${GITHUB_RUN_NUMBER}.0.0"
echo $VERSION

