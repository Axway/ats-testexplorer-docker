[![GitHub version](https://badge.fury.io/gh/Axway%2Fats-testexplorer-docker.svg)](https://badge.fury.io/gh/Axway%2Fats-testexplorer-docker)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
# ATS TestExplorer image - for container deployments
A container image with deployed ATS Test Explorer and ATS HTTP DB Logger. 
To be used in a testing (non-production) environment. An external DB will be used.

**Documentaion** is available at https://axway.github.io/ats-testexplorer/Test-Explorer---Using-the-ATS-Test-Explorer-Docker-Image.html 

**WORK still in progress**
Environment variables expected for use with remote DB:
- DB_TYPE - Database vendor. Supported values: PGSQL or MSSQL
- DB_STATE - Database action. Supported values: install, upgrade, reuse
- DB_HOST - Database host (IP or name) to be connected.
- DB_PORT - Database port to be used for connection. Defaults: 5432 for PGSQL and 1433 for MSSQL DB types. 
- DB_NAME - TestExplorer database name to be used.
- DBA_USER - Username of power user who has permissions to check available DBs and install new one.
- DBA_PASS - Password of the power user.
- DB_TE_USER - Username to be created/used for connecting the TestExplorer DB.
- DB_TE_PASS - Password to be used for connecting the TestExplorer DB.

**Download** location at https://hub.docker.com/r/axway/ats-testexplorer/

Other **related projects**:
<ul>
  <li>ATS Framework at https://github.com/Axway/ats-framework</li>
  <li>ATS Test Explorer at https://github.com/Axway/ats-testexplorer</li>
  <li>ATS HTTP DB Logger at https://github.com/Axway/ats-httpdblogger</li>
  <li>ATS Distribution at https://github.com/Axway/ats-distrib</li>
</ul>

**Contact** ATS team at: _ats.team_  _@axway.com_
aa

