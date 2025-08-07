--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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
-- Name: options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.options (
                                id integer NOT NULL,
                                question_id integer,
                                text text NOT NULL,
                                is_correct boolean NOT NULL
);


ALTER TABLE public.options OWNER TO postgres;

--
-- Name: TABLE options; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.options IS 'Варианты ответов на каждый вопрос';


--
-- Name: options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.options_id_seq OWNER TO postgres;

--
-- Name: options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.options_id_seq OWNED BY public.options.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
                                  id integer NOT NULL,
                                  test_id integer,
                                  text text NOT NULL,
                                  question_type smallint DEFAULT 0 NOT NULL,
                                  CONSTRAINT check_name CHECK ((question_type = ANY (ARRAY[0, 1])))
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: TABLE questions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.questions IS 'Вопросы по каждому тесту';


--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_id_seq OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: test_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_results (
                                     id integer NOT NULL,
                                     user_id integer NOT NULL,
                                     test_id integer NOT NULL,
                                     score integer NOT NULL,
                                     total_questions integer NOT NULL,
                                     passed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.test_results OWNER TO postgres;

--
-- Name: TABLE test_results; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.test_results IS 'Результаты прохождения тестов пользователями';


--
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.results_id_seq OWNER TO postgres;

--
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.results_id_seq OWNED BY public.test_results.id;


--
-- Name: test_results_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_results_answers (
                                             user_id integer NOT NULL,
                                             test_id integer NOT NULL,
                                             question_id integer NOT NULL,
                                             option_id integer NOT NULL,
                                             is_selected boolean DEFAULT false NOT NULL,
                                             passed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.test_results_answers OWNER TO postgres;

--
-- Name: tests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tests (
                              id integer NOT NULL,
                              title character varying(255) NOT NULL,
                              description text,
                              created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.tests OWNER TO postgres;

--
-- Name: TABLE tests; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tests IS 'Список тестов (название, описание, дата создания)';


--
-- Name: tests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tests_id_seq OWNER TO postgres;

--
-- Name: tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tests_id_seq OWNED BY public.tests.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
                              id integer NOT NULL,
                              username character varying(50) NOT NULL,
                              password_hash text NOT NULL,
                              role integer DEFAULT 1 NOT NULL,
                              email text NOT NULL
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
-- Name: options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options ALTER COLUMN id SET DEFAULT nextval('public.options_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: test_results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_results ALTER COLUMN id SET DEFAULT nextval('public.results_id_seq'::regclass);


--
-- Name: tests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests ALTER COLUMN id SET DEFAULT nextval('public.tests_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options (id, question_id, text, is_correct) FROM stdin;
1	1	Парадигма программирования, основанная на объектах	t
2	1	Язык программирования	f
3	1	Библиотека для работы с объектами	f
4	1	Способ оптимизации кода	f
5	2	Инкапсуляция	t
6	2	Наследование	t
7	2	Полиморфизм	t
8	2	Абстракция	t
9	2	Итерация	f
10	2	Компиляция	f
11	3	Сокрытие реализации и объединение данных с методами	t
12	3	Создание множества копий объекта	f
13	3	Наследование свойств родительского класса	f
14	3	Автоматическое управление памятью	f
15	4	Композиция: объект-часть не может существовать без объекта-целого	t
16	4	Агрегация: объект-часть может существовать независимо	t
17	4	Это синонимы	f
18	4	Композиция используется только в интерфейсах	f
19	5	Статическое: во время компиляции	t
20	5	Динамическое: во время выполнения	t
21	5	Статическое: для final методов	t
22	5	Динамическое: только для private методов	f
23	5	Статическое: только для статических переменных	f
24	6	Преимущество: повторное использование кода	t
25	6	Недостаток: больший расход памяти	t
26	6	Преимущество: более простая поддержка	t
27	6	Недостаток: более медленная скорость выполнения	f
28	6	Преимущество: не требует сборки мусора	f
29	7	Класс: шаблон для создания объектов	t
30	7	Объект: экземпляр класса	t
31	7	Интерфейс: контракт для классов	t
32	7	Класс: коллекция статических методов	f
33	7	Объект: синоним переменной	f
34	8	«Является» — наследование (is-a)	t
35	8	«Имеет» — композиция/агрегация (has-a)	t
36	8	«Является» — реализация интерфейса	t
37	8	«Имеет» — множественное наследование	f
38	8	«Является» — отношение между пакетами	f
39	9	Абстрактный класс может иметь состояние (поля)	t
40	9	Интерфейс может содержать default-методы	t
41	9	Абстрактный класс поддерживает конструкторы	t
42	9	Интерфейс может наследовать несколько интерфейсов	t
43	9	Абстрактный класс быстрее выполняется	f
44	9	Интерфейс может иметь final-методы	f
45	10	Перегрузка: один класс, разные параметры	t
46	10	Переопределение: подкласс изменяет метод родителя	t
47	10	Перегрузка требует одинакового возвращаемого типа	f
48	10	Переопределение возможно только для static методов	f
49	10	Перегрузка: только для private методов	f
50	11	Объект, состояние которого нельзя изменить после создания	t
51	11	Класс, все поля которого объявлены как final	t
52	11	Объект, который можно изменять через геттеры	f
53	11	Объект без методов	f
54	11	Объект, который автоматически клонируется при изменении	f
55	12	Возможность сужать тип возвращаемого значения при переопределении метода	t
56	12	Пример: метод в подклассе возвращает подтип	t
57	12	Это изменение имени метода в подклассе	f
58	12	То же самое, что перегрузка метода	f
59	12	Возможность возвращать void вместо конкретного типа	f
60	13	Для создания единственного экземпляра класса	t
61	13	Для глобального доступа к экземпляру	t
62	13	Для замены статических методов	f
63	13	Для ускорения работы программы	f
64	13	Для автоматического удаления неиспользуемых объектов	f
65	14	Принцип единственной ответственности	t
66	14	Принцип открытости/закрытости	t
67	14	Принцип подстановки Барбары Лисков	t
68	14	Принцип максимальной эффективности	f
69	14	Принцип единственной переменной	f
70	14	Принцип жесткого кодирования	f
71	15	Запрет наследования (для классов)	t
72	15	Запрет переопределения (для методов)	t
73	15	Запрет изменения ссылки (для переменных)	t
74	15	Для оптимизации скорости работы	f
75	15	Для автоматического удаления объекта	f
76	15	Для создания неизменяемых коллекций	f
77	16	B	t
78	16	A	f
79	16	Ошибка компиляции	f
80	16	Ничего не выведет	f
81	16	AB	f
82	17	Могут иметь реализацию	t
83	17	Появились в Java 8	t
84	17	Могут быть final	f
85	17	Могут обращаться к полям интерфейса	f
86	17	Заменяют абстрактные классы	f
87	18	Выполнение байт-кода	t
88	18	Управление памятью (heap, stack)	t
89	18	Обеспечение платформо-независимости	t
90	18	Компиляция исходного кода в машинный код	f
91	18	Оптимизация SQL-запросов	f
92	18	Генерация документации	f
93	19	Иерархия: Bootstrap → Platform → System class loaders	t
94	19	Реализует принцип делегирования загрузки классов	t
95	19	Bootstrap class loader написан на Java	f
96	19	Класс загружается только один раз за время работы JVM	f
97	19	ClassLoader может выгружать классы из памяти	t
98	19	Все ClassLoader-ы являются экземплярами одного класса	f
99	20	Heap (куча)	t
100	20	Stack (стек)	t
101	20	Metaspace (метаданные классов)	t
102	20	Program Counter Register	t
103	20	Native Method Stack	t
104	20	CPU Cache	f
105	20	SSD-хранилище	f
106	21	Локальные переменные	t
107	21	Операндный стек	t
108	21	Ссылка на пул констант класса	t
109	21	Байт-код текущего метода	f
110	21	Статические переменные класса	f
111	21	Ссылки на другие потоки	f
112	22	Интерпретация байт-кода	t
113	22	JIT-компиляция (Just-In-Time)	t
114	22	Использование HotSpot-оптимизаций	t
115	22	Прекомпиляция всего кода при запуске	f
116	22	Преобразование в JavaScript	f
117	22	Через внешний C++ компилятор	f
118	23	Heap: хранит объекты, Stack: хранит примитивы и ссылки	t
119	23	Heap: общий для всех потоков, Stack: свой у каждого потока	t
120	23	Heap: автоматическое управление памятью (GC), Stack: автоматическое освобождение	t
121	23	Heap: быстрее по доступу	f
122	23	Stack: хранит статические переменные	f
123	23	Heap: ограничен по размеру, Stack: неограничен	f
124	24	Удаляет объекты без ссылок	t
125	24	Использует поколенческую модель (Generational GC)	t
126	24	Может вызывать stop-the-world паузы	t
127	24	Работает в отдельном системном процессе	f
128	24	Очищает стек автоматически	f
129	24	Удаляет все объекты при завершении потока	f
130	25	Компилирует "горячий" код в нативный	t
131	25	Использует профилирование выполнения	t
132	25	Уменьшает накладные расходы интерпретатора	t
133	25	Заменяет javac компилятор	f
134	25	Работает только при запуске программы	f
135	25	Всегда компилирует весь код сразу	f
136	26	Метаданные загруженных классов	t
137	26	Структуры данных JVM для работы с классами	t
138	26	Константы времени компиляции	f
139	26	Скомпилированный нативный код	f
140	26	Статические переменные классов	f
141	26	Кэш результатов JIT-компиляции	f
142	27	Это промежуточное представление кода	t
143	27	Исполняется виртуальной машиной	t
144	27	Один и тот же для всех платформ	t
145	27	Зависит от операционной системы	f
146	27	Требует компиляции перед каждым запуском	f
147	27	Идентичен машинному коду процессора	f
148	28	Heap	t
149	28	Stack	t
150	28	Metaspace	t
151	28	Program Counter Register	t
152	28	Native Memory	f
153	28	CPU Cache	f
154	28	GPU Memory	f
155	29	Автоматическое выделение/освобождение (GC)	t
156	29	Разделение на поколения (Young, Old)	t
157	29	Использование разных алгоритмов сборки мусора	t
158	29	Ручное управление через malloc/free	f
159	29	Полная очистка при нехватке памяти	f
160	29	Использование только физической памяти	f
300	30	JDK содержит компилятор и инструменты разработки	t
301	30	JRE - среда выполнения (JVM + библиотеки)	t
302	30	JVM исполняет байт-код	t
303	30	JRE включает в себя JDK	f
304	30	JVM компилирует исходный код	f
305	31	public	t
306	31	protected	t
307	31	private	t
308	31	package-private (по умолчанию)	t
309	31	global	f
310	31	internal	f
311	32	Для класса: запрет наследования	t
312	32	Для метода: запрет переопределения	t
313	32	Для переменной: запрет изменения значения	t
314	32	Для параметра: разрешает изменение значения	f
315	32	Для интерфейса: делает все методы реализованными	f
316	33	Числовые примитивы: 0	t
317	33	boolean: false	t
318	33	char: \\u0000	t
319	33	Ссылочные типы: null	t
320	33	Локальные переменные: случайное значение	f
321	33	Все переменные требуют явной инициализации	f
322	34	Точка входа в программу	t
323	34	Должна быть public static void	t
324	34	Принимает массив String как аргумент	t
325	34	Может быть несколько main-методов в классе	f
326	34	Может возвращать int	f
327	35	&& (логическое И)	t
328	35	|| (логическое ИЛИ)	t
329	35	! (логическое НЕ)	t
330	35	^ (логическое исключающее ИЛИ)	t
331	35	& (побитовое И)	f
332	35	<< (сдвиг влево)	f
333	36	Условный оператор вида: условие ? значение1 : значение2	t
334	36	Оператор для работы с тремя переменными	f
335	36	Специальный оператор цикла	f
336	36	Оператор сравнения трех значений	f
337	37	& (И)	t
338	37	| (ИЛИ)	t
339	37	^ (исключающее ИЛИ)	t
340	37	~ (НЕ)	t
341	37	&& (логическое И)	f
342	37	! (логическое НЕ)	f
343	38	Для объявления абстрактных классов	t
344	38	Для объявления методов без реализации	t
345	38	Для запрета создания экземпляров класса	t
346	38	Для указания, что метод должен быть переопределен	t
347	38	Для создания статических методов	f
348	38	Для объявления финальных классов	f
349	39	Контракт, который должны реализовать классы. Поля: public static final, методы: public abstract	t
350	39	Базовый класс для наследования. Поля: private, методы: protected	f
351	39	Набор статических методов. Поля: final, методы: static	f
352	39	Абстрактный класс без полей. Поля: отсутствуют, методы: public	f
353	40	Абстрактный класс может содержать реализацию, интерфейс - только контракт. Использовать абстрактный класс для общей функциональности, интерфейс - для определения поведения	t
354	40	Ничем не отличаются, можно использовать что угодно	f
355	40	Интерфейс может содержать реализацию, абстрактный класс - нет	f
356	40	Абстрактный класс используется только для наследования, интерфейс - для полиморфизма	f
357	41	Для маркировки классов (marker interfaces)	t
358	41	Это ошибка в проектировании	f
359	41	Такие интерфейсы нельзя реализовать	f
360	41	Java не позволяет создавать пустые интерфейсы	f
361	42	Потому что методы интерфейса должны быть переопределяемы	t
362	42	Можно, это допустимо в Java	f
363	42	final методы не поддерживаются в Java	f
364	42	Это приведет к ошибке компиляции	f
365	43	Интерфейс	t
366	43	Абстрактный класс	f
367	43	Обычный класс	f
368	43	Все имеют одинаковый уровень абстракции	f
369	44	Да, через методы-геттеры или рефлексию	t
370	44	Нет, private переменные недоступны	f
371	44	Только если объект того же класса	f
372	44	Только через наследование	f
373	45	Статические блоки → Блоки инициализации → Конструкторы родителя → Конструкторы потомка	t
374	45	Конструкторы потомка → Конструкторы родителя → Блоки инициализации	f
375	45	Блоки инициализации → Статические блоки → Конструкторы	f
376	45	Порядок случайный	f
377	46	Для инициализации полей класса	t
378	46	Статические блоки выполняются при загрузке класса	t
379	46	Нестатические блоки выполняются перед каждым конструктором	t
380	46	Для замены конструкторов	f
381	46	Только для статических полей	f
382	47	Переменные	t
383	47	Методы	t
384	47	Блоки инициализации	t
385	47	Классы (вложенные)	t
386	47	Конструкторы	f
387	47	Интерфейсы	f
388	48	Для инициализации статических переменных при загрузке класса	t
389	48	Для выполнения кода перед созданием каждого объекта	f
390	48	Для замены конструктора	f
391	48	Для динамической загрузки классов	f
392	49	Выбросится ExceptionInInitializerError	t
393	49	Программа продолжит работу	f
394	49	Исключение будет проигнорировано	f
395	49	JVM завершит работу	f
396	50	Может быть перегружен	t
397	50	Не может быть переопределен	t
398	50	Может быть переопределен	f
399	50	Не может быть перегружен	f
400	51	Уровень доступа нельзя сузить, тип возвращаемого значения можно сузить	t
401	51	Можно сузить и то, и другое	f
402	51	Нельзя сузить ни то, ни другое	f
403	51	Можно сузить уровень доступа, но нельзя тип возвращаемого значения	f
404	52	Модификатор доступа можно только расширить	t
405	52	Возвращаемый тип можно сузить (ковариантность)	t
406	52	Тип/количество аргументов изменить нельзя	t
407	52	Можно изменить все перечисленное	f
408	52	Нельзя изменить ничего из перечисленного	f
409	53	Через ключевое слово super	t
410	53	Через ключевое слово this	f
411	53	Через рефлексию	f
412	53	Невозможно получить доступ	f
413	54	Статические члены принадлежат классу, а не экземплярам	t
414	54	Экземплярные члены доступны только через объект	f
415	54	Статические члены не могут быть изменены	f
416	54	Разницы нет, это синонимы	f
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, test_id, text, question_type) FROM stdin;
1	1	Что такое ООП?	1
2	1	Назовите основные принципы ООП:	1
3	1	Что такое "инкапсуляция"?	1
4	1	В чем разница между композицией и агрегацией?	1
5	1	Что такое статическое и динамическое связывание?	1
6	1	В чем заключаются преимущества и недостатки ООП?	1
7	1	Что представляют собой "класс", "объект", "интерфейс"?	1
8	1	Что подразумевают выражения «является» и «имеет» в ООП?	1
9	1	Чем абстрактный класс отличается от интерфейса (Java 8+)?	1
10	1	В чем разница между перегрузкой (overload) и переопределением (override)?	1
11	1	Что такое иммутабельный объект?	1
12	1	Что такое ковариантность возвращаемого типа?	1
13	1	Для чего нужен паттерн Singleton?	1
14	1	Какие принципы входят в SOLID?	1
15	1	Для чего используется модификатор final?	1
17	1	Какие утверждения о default-методах в интерфейсах верны?	1
46	3	Зачем нужны и какие бывают блоки инициализации?	1
47	3	К каким конструкциям Java применим модификатор static?	1
16	1	Что выведет код?\r\nclass A { void print() { System.out.println("A"); } }\r\nclass B extends A { void print() { System.out.println("B"); } }\r\nA obj = new B();\r\nobj.print();	1
18	2	За что отвечает JVM в экосистеме Java?	1
19	2	Какие из утверждений о ClassLoader верны?	1
20	2	Какие области данных существуют в JVM во время выполнения?	1
21	2	Что содержится в стековом фрейме (frame) JVM?	1
22	2	Как Execution Engine выполняет байт-код?	1
23	2	Чем Heap отличается от Stack в JVM?	1
24	2	Какие утверждения о Garbage Collection верны?	1
25	2	Как работает JIT-компиляция в JVM?	1
26	2	Что хранится в Metaspace?	1
27	2	Какие утверждения о байт-коде Java верны?	1
28	2	Какие компоненты входят в модель памяти JVM?	1
29	2	Как JVM управляет памятью?	1
30	3	Чем различаются JRE, JVM и JDK?	1
31	3	Какие существуют модификаторы доступа в Java?	1
32	3	О чем говорит ключевое слово final?	1
33	3	Какими значениями инициализируются переменные по умолчанию?	1
34	3	Что вы знаете о функции main()?	1
35	3	Какие логические операции и операторы вы знаете?	1
36	3	Что такое тернарный оператор выбора?	0
37	3	Какие побитовые операции вы знаете?	1
38	3	Где и для чего используется модификатор abstract?	1
39	3	Дайте определение понятию «интерфейс». Какие модификаторы по умолчанию имеют поля и методы интерфейсов?	0
40	3	Чем абстрактный класс отличается от интерфейса? В каких случаях следует использовать абстрактный класс, а в каких интерфейс?	0
41	3	Почему в некоторых интерфейсах вообще не определяют методов?	0
42	3	Почему нельзя объявить метод интерфейса с модификатором final?	0
43	3	Что имеет более высокий уровень абстракции - класс, абстрактный класс или интерфейс?	0
44	3	Может ли объект получить доступ к private-переменной класса? Если да, то каким образом?	0
45	3	Каков порядок вызова конструкторов и блоков инициализации с учётом иерархии классов?	0
48	3	Для чего в Java используются статические блоки инициализации?	0
49	3	Что произойдёт, если в блоке инициализации возникнет исключительная ситуация?	0
50	3	Может ли статический метод быть переопределён или перегружен?	1
51	3	Можно ли сузить уровень доступа/тип возвращаемого значения при переопределении метода?	0
52	3	Возможно ли при переопределении метода изменить: модификатор доступа; возвращаемый тип; тип аргумента или их количество?	1
53	3	Как получить доступ к переопределенным методам родительского класса?	0
54	3	В чем разница между членом экземпляра класса и статическим членом класса?	0
\.


--
-- Data for Name: test_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_results (id, user_id, test_id, score, total_questions, passed_at) FROM stdin;
143	2	1	8	17	2025-07-17 14:17:34.300274
145	2	3	19	25	2025-07-17 15:22:56.370564
\.


--
-- Data for Name: test_results_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_results_answers (user_id, test_id, question_id, option_id, is_selected, passed_at) FROM stdin;
2	3	46	377	t	2025-07-17 15:22:56.388319
2	3	46	378	t	2025-07-17 15:22:56.388319
2	3	46	379	t	2025-07-17 15:22:56.388319
2	3	46	380	f	2025-07-17 15:22:56.388319
2	3	46	381	f	2025-07-17 15:22:56.388319
2	3	47	382	t	2025-07-17 15:22:56.388319
2	3	47	383	t	2025-07-17 15:22:56.388319
2	3	47	384	f	2025-07-17 15:22:56.388319
2	3	47	385	t	2025-07-17 15:22:56.388319
2	3	47	386	f	2025-07-17 15:22:56.388319
2	3	47	387	f	2025-07-17 15:22:56.388319
2	3	30	300	t	2025-07-17 15:22:56.388319
2	3	30	301	t	2025-07-17 15:22:56.388319
2	3	30	302	t	2025-07-17 15:22:56.388319
2	3	30	303	f	2025-07-17 15:22:56.388319
2	3	30	304	f	2025-07-17 15:22:56.388319
2	3	31	305	t	2025-07-17 15:22:56.388319
2	3	31	306	t	2025-07-17 15:22:56.388319
2	3	31	307	t	2025-07-17 15:22:56.388319
2	3	31	308	t	2025-07-17 15:22:56.388319
2	3	31	309	f	2025-07-17 15:22:56.388319
2	3	31	310	f	2025-07-17 15:22:56.388319
2	3	32	311	t	2025-07-17 15:22:56.388319
2	3	32	312	t	2025-07-17 15:22:56.388319
2	3	32	313	t	2025-07-17 15:22:56.388319
2	3	32	314	f	2025-07-17 15:22:56.388319
2	3	32	315	f	2025-07-17 15:22:56.388319
2	3	33	316	t	2025-07-17 15:22:56.388319
2	3	33	317	t	2025-07-17 15:22:56.388319
2	3	33	318	t	2025-07-17 15:22:56.388319
2	3	33	319	t	2025-07-17 15:22:56.388319
2	3	33	320	f	2025-07-17 15:22:56.388319
2	3	33	321	f	2025-07-17 15:22:56.388319
2	3	34	322	t	2025-07-17 15:22:56.388319
2	3	34	323	t	2025-07-17 15:22:56.388319
2	3	34	324	t	2025-07-17 15:22:56.388319
2	3	34	325	f	2025-07-17 15:22:56.388319
2	3	34	326	f	2025-07-17 15:22:56.388319
2	3	35	327	t	2025-07-17 15:22:56.388319
2	3	35	328	t	2025-07-17 15:22:56.388319
2	3	35	329	t	2025-07-17 15:22:56.388319
2	3	35	330	t	2025-07-17 15:22:56.388319
2	3	35	331	f	2025-07-17 15:22:56.388319
2	3	35	332	f	2025-07-17 15:22:56.388319
2	3	36	333	t	2025-07-17 15:22:56.388319
2	3	36	334	f	2025-07-17 15:22:56.388319
2	3	36	335	f	2025-07-17 15:22:56.388319
2	1	1	1	t	2025-07-17 14:17:34.311553
2	1	1	2	f	2025-07-17 14:17:34.311553
2	1	1	3	f	2025-07-17 14:17:34.311553
2	1	1	4	f	2025-07-17 14:17:34.311553
2	1	2	5	t	2025-07-17 14:17:34.311553
2	1	2	6	t	2025-07-17 14:17:34.311553
2	1	2	7	t	2025-07-17 14:17:34.311553
2	1	2	8	t	2025-07-17 14:17:34.311553
2	1	2	9	f	2025-07-17 14:17:34.311553
2	1	2	10	f	2025-07-17 14:17:34.311553
2	1	3	11	t	2025-07-17 14:17:34.311553
2	1	3	12	f	2025-07-17 14:17:34.311553
2	1	3	13	f	2025-07-17 14:17:34.311553
2	1	3	14	f	2025-07-17 14:17:34.311553
2	1	4	15	t	2025-07-17 14:17:34.311553
2	1	4	16	t	2025-07-17 14:17:34.311553
2	1	4	17	f	2025-07-17 14:17:34.311553
2	1	4	18	f	2025-07-17 14:17:34.311553
2	1	5	19	t	2025-07-17 14:17:34.311553
2	1	5	20	t	2025-07-17 14:17:34.311553
2	1	5	21	f	2025-07-17 14:17:34.311553
2	1	5	22	f	2025-07-17 14:17:34.311553
2	1	5	23	f	2025-07-17 14:17:34.311553
2	1	6	24	t	2025-07-17 14:17:34.311553
2	1	6	25	f	2025-07-17 14:17:34.311553
2	1	6	26	t	2025-07-17 14:17:34.311553
2	1	6	27	t	2025-07-17 14:17:34.311553
2	1	6	28	f	2025-07-17 14:17:34.311553
2	1	7	29	f	2025-07-17 14:17:34.311553
2	1	7	30	f	2025-07-17 14:17:34.311553
2	1	7	31	t	2025-07-17 14:17:34.311553
2	1	7	32	f	2025-07-17 14:17:34.311553
2	1	7	33	f	2025-07-17 14:17:34.311553
2	1	8	34	t	2025-07-17 14:17:34.311553
2	1	8	35	t	2025-07-17 14:17:34.311553
2	1	8	36	f	2025-07-17 14:17:34.311553
2	1	8	37	f	2025-07-17 14:17:34.311553
2	1	8	38	f	2025-07-17 14:17:34.311553
2	1	9	39	t	2025-07-17 14:17:34.311553
2	1	9	40	t	2025-07-17 14:17:34.311553
2	1	9	41	t	2025-07-17 14:17:34.311553
2	1	9	42	t	2025-07-17 14:17:34.311553
2	1	9	43	f	2025-07-17 14:17:34.311553
2	1	9	44	f	2025-07-17 14:17:34.311553
2	1	10	45	t	2025-07-17 14:17:34.311553
2	1	10	46	t	2025-07-17 14:17:34.311553
2	1	10	47	f	2025-07-17 14:17:34.311553
2	1	10	48	f	2025-07-17 14:17:34.311553
2	1	10	49	f	2025-07-17 14:17:34.311553
2	1	11	50	t	2025-07-17 14:17:34.311553
2	1	11	51	f	2025-07-17 14:17:34.311553
2	1	11	52	f	2025-07-17 14:17:34.311553
2	1	11	53	f	2025-07-17 14:17:34.311553
2	1	11	54	f	2025-07-17 14:17:34.311553
2	1	12	55	t	2025-07-17 14:17:34.311553
2	1	12	56	f	2025-07-17 14:17:34.311553
2	1	12	57	f	2025-07-17 14:17:34.311553
2	1	12	58	f	2025-07-17 14:17:34.311553
2	1	12	59	f	2025-07-17 14:17:34.311553
2	1	13	60	t	2025-07-17 14:17:34.311553
2	1	13	61	t	2025-07-17 14:17:34.311553
2	1	13	62	f	2025-07-17 14:17:34.311553
2	1	13	63	f	2025-07-17 14:17:34.311553
2	1	13	64	f	2025-07-17 14:17:34.311553
2	1	14	65	t	2025-07-17 14:17:34.311553
2	1	14	66	t	2025-07-17 14:17:34.311553
2	1	14	67	f	2025-07-17 14:17:34.311553
2	1	14	68	f	2025-07-17 14:17:34.311553
2	1	14	69	f	2025-07-17 14:17:34.311553
2	1	14	70	f	2025-07-17 14:17:34.311553
2	1	15	71	t	2025-07-17 14:17:34.311553
2	1	15	72	t	2025-07-17 14:17:34.311553
2	1	15	73	t	2025-07-17 14:17:34.311553
2	1	15	74	f	2025-07-17 14:17:34.311553
2	1	15	75	f	2025-07-17 14:17:34.311553
2	1	15	76	t	2025-07-17 14:17:34.311553
2	1	17	82	t	2025-07-17 14:17:34.311553
2	1	17	83	t	2025-07-17 14:17:34.311553
2	1	17	84	f	2025-07-17 14:17:34.311553
2	1	17	85	f	2025-07-17 14:17:34.311553
2	1	17	86	f	2025-07-17 14:17:34.311553
2	1	16	77	f	2025-07-17 14:17:34.311553
2	1	16	78	t	2025-07-17 14:17:34.311553
2	1	16	79	f	2025-07-17 14:17:34.311553
2	1	16	80	f	2025-07-17 14:17:34.311553
2	1	16	81	f	2025-07-17 14:17:34.311553
2	3	36	336	f	2025-07-17 15:22:56.388319
2	3	37	337	t	2025-07-17 15:22:56.388319
2	3	37	338	t	2025-07-17 15:22:56.388319
2	3	37	339	t	2025-07-17 15:22:56.388319
2	3	37	340	t	2025-07-17 15:22:56.388319
2	3	37	341	f	2025-07-17 15:22:56.388319
2	3	37	342	f	2025-07-17 15:22:56.388319
2	3	38	343	t	2025-07-17 15:22:56.388319
2	3	38	344	t	2025-07-17 15:22:56.388319
2	3	38	345	t	2025-07-17 15:22:56.388319
2	3	38	346	t	2025-07-17 15:22:56.388319
2	3	38	347	f	2025-07-17 15:22:56.388319
2	3	38	348	f	2025-07-17 15:22:56.388319
2	3	39	349	t	2025-07-17 15:22:56.388319
2	3	39	350	f	2025-07-17 15:22:56.388319
2	3	39	351	f	2025-07-17 15:22:56.388319
2	3	39	352	f	2025-07-17 15:22:56.388319
2	3	40	353	f	2025-07-17 15:22:56.388319
2	3	40	354	f	2025-07-17 15:22:56.388319
2	3	40	355	f	2025-07-17 15:22:56.388319
2	3	40	356	t	2025-07-17 15:22:56.388319
2	3	41	357	t	2025-07-17 15:22:56.388319
2	3	41	358	f	2025-07-17 15:22:56.388319
2	3	41	359	f	2025-07-17 15:22:56.388319
2	3	41	360	f	2025-07-17 15:22:56.388319
2	3	42	361	t	2025-07-17 15:22:56.388319
2	3	42	362	f	2025-07-17 15:22:56.388319
2	3	42	363	f	2025-07-17 15:22:56.388319
2	3	42	364	f	2025-07-17 15:22:56.388319
2	3	43	365	t	2025-07-17 15:22:56.388319
2	3	43	366	f	2025-07-17 15:22:56.388319
2	3	43	367	f	2025-07-17 15:22:56.388319
2	3	43	368	f	2025-07-17 15:22:56.388319
2	3	44	369	t	2025-07-17 15:22:56.388319
2	3	44	370	f	2025-07-17 15:22:56.388319
2	3	44	371	f	2025-07-17 15:22:56.388319
2	3	44	372	f	2025-07-17 15:22:56.388319
2	3	45	373	t	2025-07-17 15:22:56.388319
2	3	45	374	f	2025-07-17 15:22:56.388319
2	3	45	375	f	2025-07-17 15:22:56.388319
2	3	45	376	f	2025-07-17 15:22:56.388319
2	3	48	388	t	2025-07-17 15:22:56.388319
2	3	48	389	f	2025-07-17 15:22:56.388319
2	3	48	390	f	2025-07-17 15:22:56.388319
2	3	48	391	f	2025-07-17 15:22:56.388319
2	3	49	392	t	2025-07-17 15:22:56.388319
2	3	49	393	f	2025-07-17 15:22:56.388319
2	3	49	394	f	2025-07-17 15:22:56.388319
2	3	49	395	f	2025-07-17 15:22:56.388319
2	3	50	396	f	2025-07-17 15:22:56.388319
2	3	50	397	t	2025-07-17 15:22:56.388319
2	3	50	398	f	2025-07-17 15:22:56.388319
2	3	50	399	t	2025-07-17 15:22:56.388319
2	3	51	400	f	2025-07-17 15:22:56.388319
2	3	51	401	f	2025-07-17 15:22:56.388319
2	3	51	402	f	2025-07-17 15:22:56.388319
2	3	51	403	t	2025-07-17 15:22:56.388319
2	3	52	404	t	2025-07-17 15:22:56.388319
2	3	52	405	t	2025-07-17 15:22:56.388319
2	3	52	406	f	2025-07-17 15:22:56.388319
2	3	52	407	f	2025-07-17 15:22:56.388319
2	3	52	408	f	2025-07-17 15:22:56.388319
2	3	53	409	t	2025-07-17 15:22:56.388319
2	3	53	410	f	2025-07-17 15:22:56.388319
2	3	53	411	f	2025-07-17 15:22:56.388319
2	3	53	412	f	2025-07-17 15:22:56.388319
2	3	54	413	f	2025-07-17 15:22:56.388319
2	3	54	414	f	2025-07-17 15:22:56.388319
2	3	54	415	f	2025-07-17 15:22:56.388319
2	3	54	416	t	2025-07-17 15:22:56.388319
\.


--
-- Data for Name: tests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tests (id, title, description, created_at) FROM stdin;
1	Java OOP	Тест по основам объектно-ориентированного программирования в Java	2025-07-17 11:02:34.219828
2	Java Virtual Machine (JVM)	Тест по архитектуре и работе виртуальной машины Java	2025-07-17 11:33:00.124078
3	Java Core - Основы и ООП	Основные концепции Java: JVM, модификаторы, ООП, инициализация	2025-07-17 12:06:56.944806
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password_hash, role, email) FROM stdin;
2	root	$2a$10$.gWtITc1jRSLpwRbEqEpmOJzT2VXHIeZ8He7F2i3JxM8cLvpE3dJm	0	Sergeynt88@gmail.com
4	user	$2a$10$6bK.AVoVIhOHNgSsugRzseUgWvuCEIAOb/Lef/t1OTm04m8./HWC6	1	user@mail.ru
5	user2	$2a$10$RxcjY3N.dVKy9CuLNgNPR.w5cQZSHN.xANrKE1KH3oli8ebZJYfhO	1	user2@mail.ru
\.


--
-- Name: options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.options_id_seq', 416, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 54, true);


--
-- Name: results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.results_id_seq', 145, true);


--
-- Name: tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tests_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: options options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: test_results results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_results
    ADD CONSTRAINT results_pkey PRIMARY KEY (user_id, test_id);


--
-- Name: tests tests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- Name: test_results_answers unique_user_answer_per_question; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_results_answers
    ADD CONSTRAINT unique_user_answer_per_question UNIQUE (user_id, test_id, question_id, option_id);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: options options_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: questions questions_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(id) ON DELETE CASCADE;


--
-- Name: test_results results_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_results
    ADD CONSTRAINT results_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(id);


--
-- Name: test_results results_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_results
    ADD CONSTRAINT results_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: test_results_answers user_answers_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_results_answers
    ADD CONSTRAINT user_answers_option_id_fkey FOREIGN KEY (option_id) REFERENCES public.options(id) ON DELETE CASCADE;


--
-- Name: test_results_answers user_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_results_answers
    ADD CONSTRAINT user_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: test_results_answers user_answers_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_results_answers
    ADD CONSTRAINT user_answers_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(id) ON DELETE CASCADE;


--
-- Name: test_results_answers user_answers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_results_answers
    ADD CONSTRAINT user_answers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

