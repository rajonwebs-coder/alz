This file allows you to immediately run ALZ deployment:
WHAT-IF (Preview)
az deployment mg what-if \
  --template-file alz.bicep \
  --management-group-id <tenant-root-id> \
  --parameters @alz.parameters.json

DEPLOY
az deployment mg create \
  --location australiaeast \
  --management-group-id <tenant-root-id> \
  --template-file alz.bicep \
  --parameters @alz.parameters.json