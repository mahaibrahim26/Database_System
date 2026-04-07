--
-- PostgreSQL database dump
--

\restrict 63cD7h3ERmlnZcIynqOzZQrjEvPy8CpakjejmIZacOZ6s87zQP5ZY8aXKQJjp7c

-- Dumped from database version 18.0 (Debian 18.0-1.pgdg13+3)
-- Dumped by pg_dump version 18.0 (Debian 18.0-1.pgdg13+3)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE university_management;
--
-- Name: university_management; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE university_management WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE university_management OWNER TO postgres;

\unrestrict 63cD7h3ERmlnZcIynqOzZQrjEvPy8CpakjejmIZacOZ6s87zQP5ZY8aXKQJjp7c
\connect university_management
\restrict 63cD7h3ERmlnZcIynqOzZQrjEvPy8CpakjejmIZacOZ6s87zQP5ZY8aXKQJjp7c

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: academic_staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.academic_staff (
    staff_id character(4) NOT NULL,
    f_name character varying(30) NOT NULL,
    l_name character varying(30) NOT NULL,
    title character varying(30) NOT NULL,
    department character varying(30)
);


ALTER TABLE public.academic_staff OWNER TO postgres;

--
-- Name: deliverable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deliverable (
    deliverable_id character(6) NOT NULL,
    title character varying(100) NOT NULL,
    type character varying(30) NOT NULL,
    submission_date date NOT NULL,
    approval_status character varying(20) NOT NULL,
    project_id character(5) NOT NULL,
    CONSTRAINT deliverable_approval_status_check CHECK (((approval_status)::text = ANY ((ARRAY['Submitted'::character varying, 'Approved'::character varying, 'Rejected'::character varying])::text[])))
);


ALTER TABLE public.deliverable OWNER TO postgres;

--
-- Name: expense; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expense (
    expense_id character(6) NOT NULL,
    expense_type character varying(50) NOT NULL,
    amount numeric(10,2) NOT NULL,
    expense_date date NOT NULL,
    project_id character(5) NOT NULL,
    CONSTRAINT expense_amount_check CHECK ((amount >= (0)::numeric))
);


ALTER TABLE public.expense OWNER TO postgres;

--
-- Name: fund; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fund (
    fund_id character(6) NOT NULL,
    amount numeric(12,2) NOT NULL,
    received_date date NOT NULL,
    funding_body_id character(4) NOT NULL,
    project_id character(5) NOT NULL,
    CONSTRAINT fund_amount_check CHECK ((amount >= (0)::numeric))
);


ALTER TABLE public.fund OWNER TO postgres;

--
-- Name: funding_body; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funding_body (
    funding_body_id character(4) NOT NULL,
    name character varying(50) NOT NULL,
    country character varying(30),
    type character varying(20)
);


ALTER TABLE public.funding_body OWNER TO postgres;

--
-- Name: project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project (
    project_id character(5) NOT NULL,
    coordinator_id character(4),
    title character varying(50) NOT NULL,
    status character varying(30) NOT NULL,
    start_date date NOT NULL,
    end_date date,
    total_budget numeric(12,2) NOT NULL,
    CONSTRAINT project_status_check CHECK (((status)::text = ANY ((ARRAY['Active'::character varying, 'Completed'::character varying, 'Suspended'::character varying])::text[]))),
    CONSTRAINT project_total_budget_check CHECK ((total_budget >= (0)::numeric))
);


ALTER TABLE public.project OWNER TO postgres;

--
-- Name: project_assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_assignment (
    staff_id character(4) NOT NULL,
    project_id character(5) NOT NULL,
    role_name character varying(30) NOT NULL
);


ALTER TABLE public.project_assignment OWNER TO postgres;

--
-- Name: project_field; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_field (
    project_id character(5) NOT NULL,
    field_id character(3) NOT NULL
);


ALTER TABLE public.project_field OWNER TO postgres;

--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    role_name character varying(30) NOT NULL,
    hours_per_week numeric(3,0) NOT NULL,
    CONSTRAINT role_hours_per_week_check CHECK (((hours_per_week >= (0)::numeric) AND (hours_per_week <= (40)::numeric)))
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: scientific_field; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scientific_field (
    field_id character(3) NOT NULL,
    field_name character varying(30) NOT NULL
);


ALTER TABLE public.scientific_field OWNER TO postgres;

--
-- Data for Name: academic_staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.academic_staff (staff_id, f_name, l_name, title, department) FROM stdin;
A001	Lina	Petrov	Professor	Computer Engineering
A002	Sofia	Martinez	Professor	Electrical Engineering
A003	Elena	Rossi	Professor	Bioengineering
A004	Min-Jae	Park	Postdoctoral Fellow	Computer Engineering
A005	Priya	Sharma	PhD Student	Industrial Engineering
A006	Samuel	Okoye	Professor	Energy Systems
A007	Maria	Gonzalez	Assistant Professor	Computer Engineering
A008	Omar	Hassan	Postdoctoral Fellow	Electrical Engineering
A009	Alina	Smith	Assistant Professor	Industrial Engineering
A010	John	Miller	Professor	Robotics
A011	Fatma	Celik	PhD Student	Bioengineering
A012	Li	Wei	Postdoctoral Fellow	Data Science
A013	Emre	Sahin	Research Assistant	Computer Engineering
A014	Anna	Novak	PhD Student	Energy Systems
\.


--
-- Data for Name: deliverable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deliverable (deliverable_id, title, type, submission_date, approval_status, project_id) FROM stdin;
D00001	AI System Architecture Report	Progress Report	2024-06-01	Approved	P0001
D00002	Smart Campus Prototype	Software	2024-09-15	Submitted	P0001
D00003	AI-Based Campus Optimization Paper	Journal Article	2024-11-05	Submitted	P0001
D00004	Energy Storage Performance Study	Final Report	2024-01-20	Approved	P0002
D00005	Battery Control Algorithm	Software	2024-03-10	Approved	P0002
D00006	Genomic Data Analysis Paper	Journal Article	2023-11-05	Approved	P0003
D00007	Genomic Analysis Software Toolkit	Software	2023-05-30	Approved	P0003
D00008	Hydrogen Safety Assessment	Progress Report	2023-12-10	Rejected	P0004
D00009	Hydrogen Storage Materials Review	Progress Report	2023-06-25	Approved	P0004
D00010	Robotics Lab Setup Report	Progress Report	2024-07-15	Approved	P0005
D00011	Autonomous Navigation Algorithm	Software	2024-09-01	Submitted	P0005
\.


--
-- Data for Name: expense; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expense (expense_id, expense_type, amount, expense_date, project_id) FROM stdin;
E00001	Software Licenses	20000.00	2024-05-05	P0001
E00002	Student Scholarships	100000.00	2024-06-15	P0001
E00003	Battery Testing Equipment	120000.00	2024-02-10	P0002
E00004	Field Testing Travel	25000.00	2024-04-22	P0002
E00005	Data Storage Services	80000.00	2023-09-01	P0003
E00006	Team Salaries	200000.00	2023-09-01	P0003
E00007	Safety Equipment	90000.00	2023-10-12	P0004
E00008	Consultancy Fees	55000.00	2024-01-18	P0004
E00009	Robotics Sensors	180000.00	2024-08-05	P0005
E00010	Workshop Materials	30000.00	2024-09-12	P0005
\.


--
-- Data for Name: fund; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fund (fund_id, amount, received_date, funding_body_id, project_id) FROM stdin;
F00006	100000.00	2024-03-01	FB01	P0001
F00007	100000.00	2024-04-01	FB01	P0001
F00008	100000.00	2024-06-01	FB02	P0001
F00009	200000.00	2023-12-01	FB02	P0002
F00010	200000.00	2024-03-01	FB02	P0002
F00011	100000.00	2023-01-15	FB01	P0003
F00012	100000.00	2023-07-15	FB01	P0003
F00013	200000.00	2025-04-01	FB03	P0004
F00014	150000.00	2024-07-01	FB04	P0005
F00015	150000.00	2024-10-01	FB04	P0005
\.


--
-- Data for Name: funding_body; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funding_body (funding_body_id, name, country, type) FROM stdin;
FB01	TUBITAK	Turkey	Government
FB02	European Union	Belgium	International
FB03	World Bank	USA	International
FB04	UNESCO	France	International
FB05	Ministry of Industry	Turkey	Government
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project (project_id, coordinator_id, title, status, start_date, end_date, total_budget) FROM stdin;
P0003	A003	Genomic Data Analysis Platform	Completed	2022-02-01	2024-01-31	300000.00
P0002	A002	Renewable Energy Storage Systems	Active	2023-09-01	\N	500000.00
P0001	A001	AI-Based Smart Campus	Active	2025-03-10	\N	650000.00
P0004	A006	Hydrogen Energy Research	Suspended	2023-03-10	\N	900000.00
P0005	A001	Autonomous Robotics Lab	Active	2024-06-01	\N	400000.00
\.


--
-- Data for Name: project_assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_assignment (staff_id, project_id, role_name) FROM stdin;
A001	P0001	Project Coordinator
A007	P0001	Senior Researcher
A004	P0001	Postdoctoral Researcher
A012	P0001	Postdoctoral Researcher
A005	P0001	PhD Researcher
A013	P0001	Research Assistant
A002	P0002	Project Coordinator
A008	P0002	Postdoctoral Researcher
A014	P0002	PhD Researcher
A009	P0002	Senior Researcher
A003	P0003	Project Coordinator
A011	P0003	PhD Researcher
A012	P0003	Postdoctoral Researcher
A006	P0004	Project Coordinator
A014	P0004	PhD Researcher
A008	P0004	Senior Researcher
A001	P0005	Project Coordinator
A007	P0005	Senior Researcher
A005	P0005	PhD Researcher
\.


--
-- Data for Name: project_field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_field (project_id, field_id) FROM stdin;
P0001	S01
P0001	S04
P0002	S02
P0003	S03
P0004	S05
P0005	S04
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (role_name, hours_per_week) FROM stdin;
Project Coordinator	20
Senior Researcher	30
Postdoctoral Researcher	35
PhD Researcher	25
Research Assistant	20
\.


--
-- Data for Name: scientific_field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scientific_field (field_id, field_name) FROM stdin;
S01	Artificial Intelligence
S02	Renewable Energy
S03	Bioinformatics
S04	Robotics
S05	Sustainable Energy
\.


--
-- Name: academic_staff academic_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_staff
    ADD CONSTRAINT academic_staff_pkey PRIMARY KEY (staff_id);


--
-- Name: deliverable deliverable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliverable
    ADD CONSTRAINT deliverable_pkey PRIMARY KEY (deliverable_id);


--
-- Name: expense expense_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expense
    ADD CONSTRAINT expense_pkey PRIMARY KEY (expense_id);


--
-- Name: fund fund_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund
    ADD CONSTRAINT fund_pkey PRIMARY KEY (fund_id);


--
-- Name: funding_body funding_body_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funding_body
    ADD CONSTRAINT funding_body_pkey PRIMARY KEY (funding_body_id);


--
-- Name: project_assignment project_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_assignment
    ADD CONSTRAINT project_assignment_pkey PRIMARY KEY (staff_id, project_id);


--
-- Name: project project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (project_id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_name);


--
-- Name: scientific_field scientific_field_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scientific_field
    ADD CONSTRAINT scientific_field_pkey PRIMARY KEY (field_id);


--
-- Name: deliverable deliverable_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliverable
    ADD CONSTRAINT deliverable_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id);


--
-- Name: expense expense_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expense
    ADD CONSTRAINT expense_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id);


--
-- Name: fund fund_funding_body_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund
    ADD CONSTRAINT fund_funding_body_id_fkey FOREIGN KEY (funding_body_id) REFERENCES public.funding_body(funding_body_id);


--
-- Name: fund fund_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund
    ADD CONSTRAINT fund_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id);


--
-- Name: project_assignment project_assignment_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_assignment
    ADD CONSTRAINT project_assignment_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id);


--
-- Name: project_assignment project_assignment_role_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_assignment
    ADD CONSTRAINT project_assignment_role_name_fkey FOREIGN KEY (role_name) REFERENCES public.role(role_name);


--
-- Name: project_assignment project_assignment_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_assignment
    ADD CONSTRAINT project_assignment_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.academic_staff(staff_id);


--
-- Name: project project_coordinator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_coordinator_id_fkey FOREIGN KEY (coordinator_id) REFERENCES public.academic_staff(staff_id);


--
-- Name: project_field project_field_field_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_field
    ADD CONSTRAINT project_field_field_id_fkey FOREIGN KEY (field_id) REFERENCES public.scientific_field(field_id);


--
-- Name: project_field project_field_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_field
    ADD CONSTRAINT project_field_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id);


--
-- PostgreSQL database dump complete
--

\unrestrict 63cD7h3ERmlnZcIynqOzZQrjEvPy8CpakjejmIZacOZ6s87zQP5ZY8aXKQJjp7c

