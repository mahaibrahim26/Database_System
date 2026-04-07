# R&D Directorate Database System

A relational database designed and implemented for a university 
Research & Development Directorate as part of a Databases course 
project at SRH Berlin.

## Overview

The system manages and monitors all research projects conducted 
within a university, supporting project registration, funding 
tracking, staff workload management, expense monitoring, and 
deliverable reporting.

---

## Database Design

### Conceptual Design — ER Diagram (Chen Notation)

Entities and relationships modeled:

- **Funding Body** → grants → **Fund** → allocated to → **Project**
- **Project** → incurs → **Expense**
- **Project** ↔ **Scientific Field** (many-to-many via Project_Field)
- **Project** → produces → **Deliverable**
- **Academic Staff** → coordinates → **Project** (1:M)
- **Academic Staff** ↔ **Project** (many-to-many via Project_Assignment)
- **Project Assignment** → assigned to → **Role**

### Logical Design — Relational Schema

Tables: `funding_body`, `fund`, `project`, `expense`, 
`academic_staff`, `role`, `project_assignment`, `deliverable`, 
`scientific_field`, `project_field`

Key design decisions:
- `project_assignment` resolves the M:M relationship between 
  staff and projects, with a role foreign key
- `project_field` resolves the M:M relationship between projects 
  and scientific fields
- `COALESCE(end_date, CURRENT_DATE)` used in hour calculations 
  to handle ongoing projects

---

## Implementation

- **Database:** PostgreSQL (run in Docker)
- **Dump file:** `rnd_directorate.sql`

To restore locally:
```bash
psql -U postgres -d your_database < rnd_directorate.sql
```

---

## Queries

11 analytical SQL queries were implemented:

| # | Query | Purpose |
|---|-------|---------|
| 1 | Active projects and coordinators | Project oversight |
| 2 | Team size per project (> 1 member) | Workload analysis |
| 3 | Staff and number of projects assigned | Staff involvement |
| 4 | Total hours worked per staff member | Workload estimation |
| 5 | Hours worked by specific staff on a project | Effort tracking |
| 6 | Total funds received per project | Financial monitoring |
| 7 | Expenses vs budget per project | Budget utilization |
| 8 | All approved deliverables | Reporting readiness |
| 9 | Total funding per scientific field | Funding distribution |
| 10 | Number of projects per field | Research activity |
| 11 | Projects with multiple funding bodies | Funding complexity |

---

## Data Dictionary (Summary)

| Table | Primary Key | Key Foreign Keys |
|-------|------------|-----------------|
| funding_body | funding_body_id | — |
| fund | fund_id | funding_body_id, project_id |
| project | project_id | coordinator_id |
| expense | expense_id | project_id |
| academic_staff | staff_id | — |
| role | role_name | — |
| project_assignment | staff_id + project_id | role_name |
| deliverable | deliverable_id | project_id |
| scientific_field | field_id | — |
| project_field | project_id + field_id | — |

---

## Repository Contents

- `rnd_directorate.sql` — Full PostgreSQL database dump
- `Databases_Final_Report.pdf` — Final project report (PDF)
