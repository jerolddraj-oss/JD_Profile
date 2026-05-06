# Disaster Recovery Strategy

## Primary Region
- East US

## Secondary Region
- Central US

## DR Components
- Azure Site Recovery
- Geo-redundant Storage (GRS)
- Backup Vault replication
- Terraform state replication
- Azure SQL failover groups
- AVD session host image replication

## Recovery Objectives
- RPO: 15 Minutes
- RTO: 1 Hour

## Failover Workflow
1. Trigger ASR failover
2. Validate networking
3. Reconnect AVD users
4. Validate FSLogix profile containers
5. Resume production
