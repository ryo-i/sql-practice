--
-- PostgreSQL database dump
--

\restrict 5hC6B3zuC95gE3Rbna8iaUA5qfa6eQkOpMvXslPZKVEPB17EMLzPnbfBeN4EJsG

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
-- Name: posts; Type: TABLE; Schema: public; Owner: iidaryou
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title text NOT NULL,
    content text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.posts OWNER TO iidaryou;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: iidaryou
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO iidaryou;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: iidaryou
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: iidaryou
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    age integer,
    city text,
    is_active boolean DEFAULT false
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
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: iidaryou
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: iidaryou
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: iidaryou
--

COPY public.posts (id, user_id, title, content, created_at) FROM stdin;
1	1	初めての投稿	Alice の最初の投稿です	2026-01-25 22:59:07.128589
2	2	Bobの日記	Bob が書いた投稿です	2026-01-25 22:59:07.128589
3	1	Aliceの2つ目の投稿	Alice の追加の投稿	2026-01-25 22:59:07.128589
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: iidaryou
--

COPY public.users (id, name, email, created_at, age, city, is_active) FROM stdin;
1	Alice Cooper	alice.cooper@example.com	2026-01-25 20:43:24.913606	25	Tokyo	t
2	Bob	bob@example.com	2026-01-25 20:43:24.913606	30	Osaka	t
3	Carol	carol@example.com	2026-01-25 20:43:24.913606	28	Nagoya	t
\.


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iidaryou
--

SELECT pg_catalog.setval('public.posts_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iidaryou
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: iidaryou
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


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
-- Name: idx_posts_created_at; Type: INDEX; Schema: public; Owner: iidaryou
--

CREATE INDEX idx_posts_created_at ON public.posts USING btree (created_at);


--
-- Name: idx_posts_user_id; Type: INDEX; Schema: public; Owner: iidaryou
--

CREATE INDEX idx_posts_user_id ON public.posts USING btree (user_id);


--
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: iidaryou
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 5hC6B3zuC95gE3Rbna8iaUA5qfa6eQkOpMvXslPZKVEPB17EMLzPnbfBeN4EJsG

