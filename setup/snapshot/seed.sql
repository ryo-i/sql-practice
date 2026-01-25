--
-- PostgreSQL database dump
--

\restrict C7hN3ObXluij2sIzbUJspdMa4IwwFBJCQcfqrgN5dnEwQ5UX7HerdZGyFNMhTZX

-- Dumped from database version 14.20 (Homebrew)
-- Dumped by pg_dump version 14.20 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: users; Type: TABLE; Schema: public; Owner: iidaryou
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO iidaryou;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: iidaryou
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO iidaryou;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: iidaryou
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: iidaryou
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: iidaryou
--

COPY public.users (id, name, email, created_at) FROM stdin;
3	Carol	carol@example.com	2026-01-25 18:21:47.136245
1	Alice Cooper	alice.cooper@example.com	2026-01-25 18:21:47.136245
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iidaryou
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: iidaryou
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: iidaryou
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

\unrestrict C7hN3ObXluij2sIzbUJspdMa4IwwFBJCQcfqrgN5dnEwQ5UX7HerdZGyFNMhTZX

