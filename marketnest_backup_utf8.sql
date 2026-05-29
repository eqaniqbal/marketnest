--
-- PostgreSQL database dump
--

\restrict 0Eupswa9Yo0EpNlGr4RzpbQhdsnVVIx8IbBdNHnD5g6Zkh8mjV3t6PULZk4WfbB

-- Dumped from database version 16.12
-- Dumped by pg_dump version 16.12

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

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    id integer NOT NULL,
    buyer_id integer,
    product_id integer,
    quantity integer DEFAULT 1,
    variant text,
    added_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_id_seq OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;


--
-- Name: coupons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coupons (
    id integer NOT NULL,
    seller_id integer,
    code character varying(50) NOT NULL,
    discount_type character varying(10),
    discount_value numeric(10,2) NOT NULL,
    min_order_amount numeric(10,2) DEFAULT 0,
    start_date date,
    end_date date,
    is_active boolean DEFAULT true,
    CONSTRAINT coupons_discount_type_check CHECK (((discount_type)::text = ANY ((ARRAY['percent'::character varying, 'flat'::character varying])::text[])))
);


ALTER TABLE public.coupons OWNER TO postgres;

--
-- Name: coupons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coupons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coupons_id_seq OWNER TO postgres;

--
-- Name: coupons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coupons_id_seq OWNED BY public.coupons.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    sender_id integer,
    receiver_id integer,
    product_id integer,
    content text,
    image_url text,
    is_seen boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer,
    product_id integer,
    seller_id integer,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    variant text
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    buyer_id integer,
    total_amount numeric(10,2) NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying,
    shipping_address text NOT NULL,
    delivery_method character varying(20) DEFAULT 'standard'::character varying,
    payment_method character varying(20),
    payment_status character varying(20) DEFAULT 'pending'::character varying,
    coupon_code character varying(50),
    discount_amount numeric(10,2) DEFAULT 0,
    tracking_id character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'confirmed'::character varying, 'packed'::character varying, 'shipped'::character varying, 'delivered'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    seller_id integer,
    name character varying(200) NOT NULL,
    description text,
    category character varying(100),
    price numeric(10,2) NOT NULL,
    discount_price numeric(10,2),
    sku character varying(100),
    stock_quantity integer DEFAULT 0,
    variants jsonb,
    images text[],
    is_approved boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    buyer_id integer,
    product_id integer,
    rating integer,
    comment text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    order_id integer,
    buyer_id integer,
    amount numeric(10,2) NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying,
    payment_method character varying(20),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    role character varying(10) NOT NULL,
    full_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    phone character varying(20),
    password_hash text NOT NULL,
    store_name character varying(100),
    store_description text,
    store_logo text,
    business_address text,
    bank_details text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['seller'::character varying, 'buyer'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: wishlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wishlist (
    id integer NOT NULL,
    buyer_id integer,
    product_id integer,
    added_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.wishlist OWNER TO postgres;

--
-- Name: wishlist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wishlist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wishlist_id_seq OWNER TO postgres;

--
-- Name: wishlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wishlist_id_seq OWNED BY public.wishlist.id;


--
-- Name: cart id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);


--
-- Name: coupons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupons ALTER COLUMN id SET DEFAULT nextval('public.coupons_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: wishlist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlist ALTER COLUMN id SET DEFAULT nextval('public.wishlist_id_seq'::regclass);


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (id, buyer_id, product_id, quantity, variant, added_at) FROM stdin;
\.


--
-- Data for Name: coupons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coupons (id, seller_id, code, discount_type, discount_value, min_order_amount, start_date, end_date, is_active) FROM stdin;
1	3	CASH2026	flat	100.00	0.00	2026-03-30	2026-04-04	t
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, sender_id, receiver_id, product_id, content, image_url, is_seen, created_at) FROM stdin;
1	2	1	\N	hello	\N	f	2026-03-30 01:11:20.537712
2	2	1	\N	when will my order reach	\N	f	2026-03-30 01:11:28.052336
3	2	3	\N	hello how can i buy this	\N	t	2026-03-30 06:53:05.135453
4	3	2	\N	you can buy this via cart	\N	f	2026-03-30 07:31:55.328477
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, seller_id, quantity, unit_price, variant) FROM stdin;
1	1	1	\N	1	2.00	\N
2	2	1	3	2	2.00	\N
13	1	1	3	1	99.00	\N
14	1	12	3	1	180000.00	\N
15	1	13	3	1	95000.00	\N
16	1	14	15	1	1500.00	\N
17	1	15	15	1	3000.00	\N
18	1	16	16	1	120000.00	\N
19	1	17	16	1	5000.00	\N
20	1	18	3	1	2500.00	\N
21	1	19	15	1	6000.00	\N
22	1	20	16	1	3500.00	\N
23	17	13	3	1	95000.00	\N
24	17	18	3	1	2500.00	\N
25	17	1	3	1	99.00	\N
26	17	12	3	1	180000.00	\N
27	17	21	3	1	40000.00	\N
28	18	25	3	1	11000.00	\N
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, buyer_id, total_amount, status, shipping_address, delivery_method, payment_method, payment_status, coupon_code, discount_amount, tracking_id, created_at) FROM stdin;
1	2	2.00	confirmed	jwenoiewrijew, ksaows, skajkw, siowi	standard	wallet	pending	\N	0.00	\N	2026-03-30 01:10:33.914229
2	2	304.00	delivered	jwenoiewrijew, ksaows, skajkw, siowi	express	wallet	pending	\N	0.00	\N	2026-03-30 02:33:54.974518
3	2	170000.00	delivered	Karachi	standard	card	paid	\N	0.00	\N	2026-03-30 06:44:12.626589
4	5	90000.00	shipped	Lahore	standard	cod	pending	\N	0.00	\N	2026-03-30 06:44:12.626589
5	6	1200.00	delivered	Islamabad	standard	card	paid	\N	0.00	\N	2026-03-30 06:44:12.626589
6	7	2500.00	confirmed	Multan	standard	cod	pending	\N	0.00	\N	2026-03-30 06:44:12.626589
7	8	115000.00	delivered	Peshawar	standard	card	paid	\N	0.00	\N	2026-03-30 06:44:12.626589
8	9	4500.00	packed	Quetta	standard	cod	pending	\N	0.00	\N	2026-03-30 06:44:12.626589
9	10	2000.00	delivered	Hyderabad	standard	card	paid	\N	0.00	\N	2026-03-30 06:44:12.626589
10	11	5500.00	cancelled	Sukkur	standard	cod	pending	\N	0.00	\N	2026-03-30 06:44:12.626589
11	12	3000.00	delivered	Karachi	standard	card	paid	\N	0.00	\N	2026-03-30 06:44:12.626589
12	13	38000.00	shipped	Lahore	standard	card	paid	\N	0.00	\N	2026-03-30 06:44:12.626589
13	2	3500.00	delivered	Karachi	standard	card	paid	\N	0.00	\N	2026-03-30 06:49:28.530625
14	2	6500.00	shipped	Karachi	standard	cod	pending	\N	0.00	\N	2026-03-30 06:49:28.530625
15	2	4000.00	delivered	Karachi	standard	card	paid	\N	0.00	\N	2026-03-30 06:49:28.530625
16	2	11000.00	confirmed	Karachi	standard	cod	pending	\N	0.00	\N	2026-03-30 06:49:28.530625
17	2	2000.00	delivered	Karachi	standard	card	paid	\N	0.00	\N	2026-03-30 06:49:28.530625
18	2	11000.00	pending	lane 12 , Lahore, Punjab, 2000	express	wallet	pending	\N	0.00	\N	2026-03-30 06:56:11.579933
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, seller_id, name, description, category, price, discount_price, sku, stock_quantity, variants, images, is_approved, is_active, created_at) FROM stdin;
14	15	Men T-Shirt	Cotton shirt	Fashion	1500.00	1200.00	\N	50	\N	{/uploads/1774843153081.jpg,/uploads/1774843153081.jpg}	t	t	2026-03-30 06:42:21.843952
15	15	Jeans Pant	Denim jeans	Fashion	3000.00	2500.00	\N	30	["Blue", "Black", "Stone"]	{/uploads/1774843372711.jpg,/uploads/1774843372711.jpg,/uploads/1774843372711.jpg}	t	t	2026-03-30 06:42:21.843952
19	15	Sneakers	Running shoes	Fashion	6000.00	5500.00	\N	15	\N	{/uploads/1774843494863.jpg,/uploads/1774843494863.jpg,/uploads/1774843494863.jpg}	t	t	2026-03-30 06:42:21.843952
16	16	Laptop HP	Core i7 laptop	Electronics	120000.00	115000.00	\N	7	\N	{/img5.jpg}	t	t	2026-03-30 06:42:21.843952
17	16	Headphones	Wireless headphones	Accessories	5000.00	4500.00	\N	20	\N	{/img6.jpg}	t	t	2026-03-30 06:42:21.843952
20	16	Backpack	Travel bag	Accessories	3500.00	3000.00	\N	18	\N	{/img9.jpg}	t	t	2026-03-30 06:42:21.843952
1	3	jsfijs	znc skjdnsj	Electronics	99.00	2.00	ski100	84	["jkdsaodoai"]	{/uploads/1774811520319.png}	t	f	2026-03-30 00:12:00.358096
25	3	Office Chair	Ergonomic chair	Other	12000.00	11000.00	\N	9	["Red", "Black"]	{/uploads/1774839930658.png,/uploads/1774839930695.png}	t	t	2026-03-30 06:48:37.081944
21	3	Tablet	Android tablet	Electronics	40000.00	38000.00	\N	12	["Black", "Grey", "Blue"]	{/uploads/1774840412954.png}	t	t	2026-03-30 06:42:21.843952
18	3	Gaming Mouse	RGB mouse	Electronics	2500.00	2000.00	\N	25	["Green", "Black", "Purple"]	{/uploads/1774840722253.png,/uploads/1774840722259.png,/uploads/1774840722322.png}	t	t	2026-03-30 06:42:21.843952
13	3	Samsung TV	Smart LED TV	Electronics	95000.00	90000.00	\N	5	\N	{/uploads/1774840944952.png,/uploads/1774840944958.png,/uploads/1774840944965.png}	t	t	2026-03-30 06:42:21.843952
12	3	iPhone 13	Apple smartphone	Electronics	180000.00	170000.00	\N	10	["Red", "Blue", "Skin"]	{/uploads/1774841151086.png,/uploads/1774841151091.png,/uploads/1774841151099.png}	t	t	2026-03-30 06:42:21.843952
26	3	Power Bank	10000mAh battery	Electronics	2500.00	2000.00	\N	30	\N	{/uploads/1774841240064.png}	t	t	2026-03-30 06:48:37.081944
24	3	Keyboard	Mechanical keyboard	Electronics	4500.00	4000.00	\N	25	["Black", "White", "Pink"]	{/uploads/1774841447116.png,/uploads/1774841447121.png,/uploads/1774841447123.png}	t	t	2026-03-30 06:48:37.081944
23	3	Smart Watch	Fitness tracker	Electronics	7000.00	6500.00	\N	15	["Blue", "Skin", "Black"]	{/uploads/1774841646708.png,/uploads/1774841646713.png,/uploads/1774841646724.png}	t	t	2026-03-30 06:48:37.081944
22	3	Bluetooth Speaker	Portable speaker	Electronics	4000.00	3500.00	\N	20	\N	{/uploads/1774841814743.jpg}	t	t	2026-03-30 06:48:37.081944
27	3	Notebook	Premium Notebook	Books	100.00	\N	PK100	1000	["Blue", "Red"]	{/uploads/1774839883192.png,/uploads/1774839883249.png}	t	t	2026-03-30 07:46:32.081569
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, buyer_id, product_id, rating, comment, created_at) FROM stdin;
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, order_id, buyer_id, amount, status, payment_method, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, role, full_name, email, phone, password_hash, store_name, store_description, store_logo, business_address, bank_details, is_active, created_at) FROM stdin;
2	buyer	Eqan Iqbal	buyer@gmail.com	03123456789	$2b$10$15sIhofrP8G3Am5ZP9XmE.NXI919RWNVO6yr/pQe/uHF2Bj/Q07he	\N	\N	\N	\N	\N	t	2026-03-29 20:26:08.410926
3	seller	Muhammad Emad	seller@gmail.com	03987654321	$2b$10$rHXhrQBdYjx.gvDKl9RgK.8VMEZfqecle7Viynxr5CfZG.f2/19U.	Cash & Carry	\N	\N	Lahore,Pakistan	\N	t	2026-03-29 20:30:26.949355
1	admin	Admin User	admin@marketnest.com	\N	$2a$10$XuFTikeE0QnXQqs2WITUeO6b6DfNPoVL0kaTrMpEvRPSBBSDSISqe	\N	\N	\N	\N	\N	t	2026-03-28 14:50:42.509226
5	buyer	Ali Khan	ali1@gmail.com	03000000001	$2a$10$cYSaOjnAORG6FI/zFNXG8OmyHsF0M/eE4wFbnk5wJI.xFQ6gXIhWK	\N	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
6	buyer	Sara Ahmed	sara1@gmail.com	03000000002	$2a$10$7IsK/8pijyjoQ05OEgt9C.9fhSgYiwI7wxCUQCk2SvDLXI6fNVb2i	\N	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
7	buyer	Usman Tariq	usman1@gmail.com	03000000003	$2a$10$DGi3YWfL/MC1vCzxrrzHnupZsvED2jNCAlSsKz9XeiA.3g1ALeYZ2	\N	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
8	buyer	Hassan Raza	hassan@gmail.com	03000000004	$2a$10$W1/l5qFgsuqDyN1jm/iED.VBOBq5dkc7uPkiLMj7Za.anKO5.90gm	\N	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
9	buyer	Fatima Noor	fatima@gmail.com	03000000005	$2a$10$jO5VIcTSZU1j5q388Is1ueS9MKB9Q2Aav.CWpcGUkgceIVPB/9nOG	\N	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
10	buyer	Bilal Shah	bilal@gmail.com	03000000006	$2a$10$FdPh1i8uqHxhVKbFP0Jmee3NNznex8JymRxrKvWVxrX1wTNnF27Ue	\N	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
11	buyer	Ayesha Malik	ayesha@gmail.com	03000000007	$2a$10$fdvss/JDBC20O8vvYOMsxu8P4vx7HK8h7x5JQqX5EWBmNxid7SPce	\N	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
12	buyer	Zain Ali	zain@gmail.com	03000000008	$2a$10$0SdGmVBRpmHQPUua81iZjuSZtUfRDiPVjIldtnuEnF0mC8HZzWQvG	\N	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
13	buyer	Hamza Khan	hamza@gmail.com	03000000009	$2a$10$mNx/8uOloHtXSKKl8mdUQOmb6W4.yrWdEWK/FL37gq9b/Znq.ZlwS	\N	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
14	buyer	Iqra Siddiqui	iqra@gmail.com	03000000010	$2a$10$lAZmHzyIwAQd7oTMHcw2cOBkPuWG2rbY6Uf6wwavs8U.EBjyriHvm	\N	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
15	seller	Tech Store	tech@gmail.com	03111111101	$2a$10$m4wypCR7zyjNwFJR6sxcS.Wa7hkRyg0tVp6Cvng6Wksdejqsz5eGO	Tech World	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
16	seller	Fashion Hub	fashion@gmail.com	03111111102	$2a$10$vXqOmO3eb8RjCMhEGjuepOOPfxq12bwpWWw8iiSkaaYtxNgSB0NFK	Fashion Hub	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
17	seller	Mobile Zone	mobile@gmail.com	03111111103	$2a$10$Z0Hdqv7Q/kQiQr6wTu87eupGwqc4E7feKSb8x7wpx9J1X8kNdWZKq	Mobile Zone	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
18	seller	Home Store	home@gmail.com	03111111104	$2a$10$PXBmHMu/k8kJscfkqvUaSeDq/BVphF9h1V/VCJVrYvjtkdybDlLq.	Home Store	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
19	seller	Sports Shop	sports@gmail.com	03111111105	$2a$10$UA9dNQILIjCxQw1VQfW0B.RHNyIoNvFLwQX5IH8t.cu18JxrfNI6m	Sports Shop	\N	\N	\N	\N	t	2026-03-30 06:39:12.349807
\.


--
-- Data for Name: wishlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wishlist (id, buyer_id, product_id, added_at) FROM stdin;
\.


--
-- Name: cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_id_seq', 3, true);


--
-- Name: coupons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.coupons_id_seq', 1, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 4, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 28, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 18, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 27, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 20, true);


--
-- Name: wishlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wishlist_id_seq', 1, true);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- Name: coupons coupons_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_code_key UNIQUE (code);


--
-- Name: coupons coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products products_sku_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_sku_key UNIQUE (sku);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wishlist wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_pkey PRIMARY KEY (id);


--
-- Name: idx_cart_buyer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cart_buyer ON public.cart USING btree (buyer_id);


--
-- Name: idx_coupons_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_coupons_code ON public.coupons USING btree (code);


--
-- Name: idx_coupons_seller; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_coupons_seller ON public.coupons USING btree (seller_id);


--
-- Name: idx_messages_receiver; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_messages_receiver ON public.messages USING btree (receiver_id);


--
-- Name: idx_messages_seen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_messages_seen ON public.messages USING btree (receiver_id, is_seen);


--
-- Name: idx_messages_sender; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_messages_sender ON public.messages USING btree (sender_id);


--
-- Name: idx_order_items_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_order ON public.order_items USING btree (order_id);


--
-- Name: idx_order_items_seller; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_seller ON public.order_items USING btree (seller_id);


--
-- Name: idx_orders_buyer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_buyer ON public.orders USING btree (buyer_id);


--
-- Name: idx_orders_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_created ON public.orders USING btree (created_at DESC);


--
-- Name: idx_orders_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_status ON public.orders USING btree (status);


--
-- Name: idx_products_approved; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_products_approved ON public.products USING btree (is_approved, is_active);


--
-- Name: idx_products_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_products_category ON public.products USING btree (category);


--
-- Name: idx_products_seller; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_products_seller ON public.products USING btree (seller_id);


--
-- Name: idx_reviews_buyer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_buyer ON public.reviews USING btree (buyer_id);


--
-- Name: idx_reviews_product; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_product ON public.reviews USING btree (product_id);


--
-- Name: idx_transactions_buyer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transactions_buyer ON public.transactions USING btree (buyer_id);


--
-- Name: idx_transactions_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transactions_order ON public.transactions USING btree (order_id);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: idx_users_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_role ON public.users USING btree (role);


--
-- Name: idx_wishlist_buyer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_wishlist_buyer ON public.wishlist USING btree (buyer_id);


--
-- Name: cart cart_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: cart cart_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: coupons coupons_seller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: messages messages_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: messages messages_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public.users(id);


--
-- Name: messages messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: order_items order_items_seller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.users(id);


--
-- Name: orders orders_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.users(id);


--
-- Name: products products_seller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.users(id);


--
-- Name: reviews reviews_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.users(id);


--
-- Name: transactions transactions_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: wishlist wishlist_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: wishlist wishlist_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 0Eupswa9Yo0EpNlGr4RzpbQhdsnVVIx8IbBdNHnD5g6Zkh8mjV3t6PULZk4WfbB

